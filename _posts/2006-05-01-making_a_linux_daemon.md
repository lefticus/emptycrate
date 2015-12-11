---
layout: blog_post
title: Making a Linux Daemon
published: true
date: '2006-05-01 15:15:34'
redirect_from:
- content/making-linux-daemon/
- node/4284/
- import_node/219/
tags:
- Programming
---

I just faced this problem at work and found a great little document that gave me the insight I needed. I'm posting it here for anyone else who is interested. <http://www.linuxprofilm.com/articles/linux-daemon-howto.html> *Update* This page is currently the most popular on the site and it was well overdue for a refresh. As stated in comments below the simplest way to do this in Linux is to use the `daemon()` system call. However, this function does not exist in System V based Unix distributions (ie, Solaris). The basic concept that needs to happen is that your application forks itself and shuts down its standard input/output/error connections. The C++ code I use for this is:

    //! daemonize the currently running programming
    //! Note: the calls to strerror are not thread safe, but that should not matter
    //! as the application is only just starting up when this function is called
    //! \param[in] dir which dir to ch to after becoming a daemon
    //! \param[in] stdinfile file to redirect stdin to
    //! \param[in] stdoutfile file to redirect stdout from
    //! \param[in] stderrfile file to redirect stderr to
    void System::daemonize(const string &dir = "/",
                   const std::string &stdinfile = "/dev/null",
                   const std::string &stdoutfile = "/dev/null",
                   const std::string &stderrfile = "/dev/null")
    {
      umask(0);

      rlimit rl;
      if (getrlimit(RLIMIT_NOFILE, &rl) < 0) 
      {
        //can't get file limit
        throw std::runtime_error(strerror(errno));
      }

      pid_t pid;
      if ((pid = fork()) < 0) 
      {
        //Cannot fork!
        throw std::runtime_error(strerror(errno));
      } else if (pid != 0) { //parent
        exit(0);
      }

      setsid();

      if (!dir.empty() && chdir(dir.c_str()) < 0) 
      {
        // Oops we couldn't chdir to the new directory
        throw std::runtime_error(strerror(errno));
      }

      if (rl.rlim_max == RLIM_INFINITY) 
      {
        rl.rlim_max = 1024;
      }

      // Close all open file descriptors
      for (unsigned int i = 0; i < rl.rlim_max; i++) 
      {
        close(i);
      }

      int fd0 = open(stdinfile.c_str(), O_RDONLY);
      int fd1 = open(stdoutfile.c_str(),
          O_WRONLY|O_CREAT|O_APPEND, S_IRUSR|S_IWUSR);
      int fd2 = open(stderrfile.c_str(),
          O_WRONLY|O_CREAT|O_APPEND, S_IRUSR|S_IWUSR);

      if (fd0 != STDIN_FILENO || fd1 != STDOUT_FILENO || fd2 != STDERR_FILENO) 
      {
        //Unexpected file descriptors
        throw runtime_error("new standard file descriptors were not opened as expected");
      }
    }

By removing the references to `std::string` and `throw` this code is easily converted to C code. The book "Advanced Programming in the UNIX Environment" covers in depth how to deamonize a process, why you would want to and what happens under the hood. I keep it as a desk reference and highly recommend it. The hardback version: [Advanced Programming in the UNIX(R) Environment (2nd Edition) (Addison-Wesley Professional Computing Series)](http://www.amazon.com/gp/product/0201433079?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0201433079)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=0201433079) And paperback is now available too: [Advanced Programming in the UNIX Environment: Paperback Edition (2nd Edition) (Addison-Wesley Professional Computing Series)](http://www.amazon.com/gp/product/0321525949?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0321525949)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=0321525949)
