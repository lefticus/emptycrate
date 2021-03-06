---
layout: blog_post
title: Create a WMI Application - Refined
published: true
date: '2009-03-20 19:39:30'
redirect_from:
- content/create-wmi-application-refined/
- node/4350/
- import_node/376/
- node/376/
tags:
- RAII
- C++
- WMI
- WQL
---

I recently had the need to be able to query the [WMI](http://msdn.microsoft.com/en-us/library/aa394582.aspx) via [WQL](http://msdn.microsoft.com/en-us/library/aa394606(VS.85).aspx) (which are very fascinating and helpful technologies, actually) from C++. WQL essentially provides an [SQL](http://en.wikipedia.org/wiki/SQL) interface for querying system properties of a running computer. 

The process of running and returning a WQL query from C++ has several steps to it, so I found the [official example](http://msdn.microsoft.com/en-us/library/aa390418(VS.85).aspx) for how to do this on Microsoft's website. 

I will not quote the full original code here, but I will comment on it. It makes a pretty good object lesson in how to not program in C++.

1.  The MFC regularly returns [pointers](/content/nobody-understands-c-part-6-are-you-still-using-pointers) to new objects.
    
    While not a fault of the code sample author it is a no-no and does result in making memory management much harder. Also, it leads right into point #2.

2.  There are at least two known memory leaks in the sample.
    
    It fails to call `pclsObj->Release()` after each inner loop operation and also fails to call `pEnumerator->Release()` after the query execution is completed. I commented on this on the MSDN page, hopefully the sample will get fixed.
         
    I verified these memory leaks by watching memory usage in debug mode of Visual Studio.

3.  There are many examples of code repeating that could be eliminated.
    
    ```cpp
    if (FAILED(hres))
    {
      cout Release();
      pLoc->Release();     
      CoUninitialize();
      return 1;               // Program has failed.
    }
    ```
   
    The above is repeated in whole or in part five times throughout the example.

4.  [RAII](/content/nobody-understands-c-part-2-raii) is not used to manage the resources or the state of the code

    Without RAII techniques it is very difficult to guarantee that all resources will be freed and the state of `CoInitialize()` will be returned to normal when an error occurs or even when the code exits normally.
   
    By putting RAII to use we are able to reduce our error handling code to simple C++ exception throwing and we can let the process of stack unwinding cleanup the state of the system for us.

5.  Does not work with C++ standard library

    While not specifically a problem with the sample, if you need to provide the ability to perform WQL queries in crossplatform capable code (obviously either returning nothing or throwing an exception on non-windows platforms) you need to be able to return `std::string`s instead of `BSTR` values. I have enhanced the example to show how to convert a `VARIANT` of any type to a `BSTR VARIANT` then to convert the resulting `BSTR` to a standard C++ string.


Our "refined" version follows: 

```cpp
#include <vector>
#include <string>
#include <sstream>
#include <map>
 
#define _WIN32_DCOM
#include <iostream>
using namespace std;
#include <comdef.h>
#include <wbemidl.h>
 
# pragma comment(lib, "wbemuuid.lib")
 
std::wstring str_to_wstr( const std::string& str )
{
  std::wstring wstr( str.length()+1, 0 );
 
  MultiByteToWideChar( CP_ACP,
             0,
             str.c_str(),
             str.length(),
             &wstr[0],
             str.length() );
  wstr.resize(str.length());

  return wstr;
}

std::string wstr_to_str( const std::wstring& wstr )
{
  size_t size = wstr.length();
  std::string str( size + 1, 0 );
 
  WideCharToMultiByte( CP_ACP,
             0,
             wstr.c_str(),
             size,
             &str[0],
             size,
             NULL,
             NULL );

  str.resize(wstr.length());

  return str;
}
 
template<typename t="">
  std::string to_string(const T &t)
  {
    std::stringstream ss;
    ss  > Dataset;
 
  //Struct to initialize and deinitialize COM state.
  struct CoInitializeGuard
  {
    CoInitializeGuard()
    {
      // Initialize COM.
      HRESULT hres =  CoInitializeEx(0, COINIT_MULTITHREADED);
      if (FAILED(hres))
      {
        throw std::runtime_error("Failed to initialize COM Library. Error code " + to_string(hres));
      }
    }
 
    ~CoInitializeGuard()
    {
      CoUninitialize();
    }
  };
 
  //Manages call to CoInitializedSecurity
  struct CoInitializeSecurityGuard
  {
    CoInitializeSecurityGuard()
    {
      // Initialize
      HRESULT hres =  CoInitializeSecurity(
        NULL,    
        -1,      // COM negotiates service                 
        NULL,    // Authentication services
        NULL,    // Reserved
        RPC_C_AUTHN_LEVEL_DEFAULT,    // authentication
        RPC_C_IMP_LEVEL_IMPERSONATE,  // Impersonation
        NULL,             // Authentication info
        EOAC_NONE,        // Additional capabilities
        NULL              // Reserved
        );
 
 
      if (FAILED(hres))
      {
        throw std::runtime_error("Failed to initialize security. Error code " + to_string(hres));
      }
    }
 
    ~CoInitializeSecurityGuard()
    {
    }
  };
 
  //Manages lifetime of IWbemLocator object
  struct CoCreateInstanceGuard
  {
    // Obtain the initial locator to Windows Management
    // on a particular host computer.
    IWbemLocator *pLoc;
 
    CoCreateInstanceGuard()
      : pLoc(0)
    {
      HRESULT hres = CoCreateInstance(
        CLSID_WbemLocator,            
        0,
        CLSCTX_INPROC_SERVER,
        IID_IWbemLocator, (LPVOID *) &pLoc);
 
      if (FAILED(hres))
      {
        throw std::runtime_error("Failed to create IWbemLocator object. Error code " + to_string(hres));
      }
    }
 
    ~CoCreateInstanceGuard()
    {
      pLoc->Release();    
    }
  };
 
  //Manages lifetime of IWbemServices object
  struct ConnectServerGuard
  {
    IWbemServices *pSvc;
    ConnectServerGuard(IWbemLocator *pLoc)
      : pSvc(0)
    {
      // Connect to the root\cimv2 namespace with the
      // current user and obtain pointer pSvc
      // to make IWbemServices calls.
      HRESULT hres = pLoc->ConnectServer(
        _bstr_t(L"ROOT\\CIMV2"), // WMI namespace
        NULL,                    // User name
        NULL,                    // User password
        0,                       // Locale
        NULL,                    // Security flags                
        0,                       // Authority      
        0,                       // Context object
        &pSvc                    // IWbemServices proxy
        );                            

      if (FAILED(hres))
      {
        throw std::runtime_error("Could not connect to WMI Server. Error code " + to_string(hres));
      }
    }
    ~ConnectServerGuard()
    {
      pSvc->Release();
    }
  };
 
  //Manages call to CoSetProxyBlanket
  struct CoSetProxyBlanketGuard
  {
    CoSetProxyBlanketGuard(IWbemServices *pSvc)
    {
      // Set the IWbemServices proxy so that impersonation
      // of the user (client) occurs.
      HRESULT hres = CoSetProxyBlanket(
        pSvc,                         // the proxy to set
        RPC_C_AUTHN_WINNT,            // authentication service
        RPC_C_AUTHZ_NONE,             // authorization service
        NULL,                         // Server principal name
        RPC_C_AUTHN_LEVEL_CALL,       // authentication level
        RPC_C_IMP_LEVEL_IMPERSONATE,  // impersonation level
        NULL,                         // client identity
        EOAC_NONE                     // proxy capabilities    
        );
 
      if (FAILED(hres))
      {
        throw std::runtime_error("Could not set proxy blanket. Error code " + to_string(hres));
      }
    }
    ~CoSetProxyBlanketGuard()
    {
    }
  };
  
  CoInitializeGuard cig;
  CoInitializeSecurityGuard cisg;
  CoCreateInstanceGuard ccig;
  ConnectServerGuard csg;
  CoSetProxyBlanketGuard cspb;
 
  //By using RAII WMI is only created if all phases succeed.
  //if any piece fails then the resources are freed that did succeed
  //during stack unrolling of the WMI object.
  //
  //Also, the destruction of the WMI object under normal circumstances
  //similarly results in the unrolling of each piece and the resources being
  //returned.
  WMI()
    : csg(ccig.pLoc), cspb(csg.pSvc)
  { 
  }
 
  void runQuery(const std::string &query)
  {
    // Use the IWbemServices pointer to make requests of WMI.
    // Make requests here:
 
    // For example, query for all the running processes
    IEnumWbemClassObject* pEnumerator = NULL;
 
    HRESULT hres = csg.pSvc->ExecQuery(
      bstr_t("WQL"),
      bstr_t(query.c_str()),
      WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
      NULL,
      &pEnumerator);
 
    if (FAILED(hres))
    {
      throw std::runtime_error("WMI query failed. Error code " + to_string(hres));
    }
    else
    {
      IWbemClassObject *pclsObj;
      ULONG uReturn = 0;
  
      while (pEnumerator)
      {
        hres = pEnumerator->Next(WBEM_INFINITE, 1,
          &pclsObj, &uReturn);
 
        if(0 == uReturn)
        {
          break;
        }
 
        if (pclsObj->BeginEnumeration(WBEM_FLAG_NONSYSTEM_ONLY) == WBEM_S_NO_ERROR)
        {
          BSTR name;
          VARIANT value;
 
          while (pclsObj->Next(0, &name, &value,0,0) == WBEM_S_NO_ERROR)
          {
            // Get the value of the Name property
           
            VariantChangeType(&value, &value, 0, VT_BSTR);
 
            //Note: unicode characters are not transliterated, the are preserved if they
            // exist and may case display problems.           
            cout Release();
        }
      }
      pEnumerator->Release();
    }
  }
};

int main(int argc, char* argv[])
{
    WMI wmi;
    wmi.runQuery("select Dependent from win32_usbcontrollerdevice");

  return 0;   // Program successfully completed.
}
```
