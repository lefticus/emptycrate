---
layout: blog_post
title: Javascript Mandelbrot Browser
published: true
date: '2009-01-24 19:33:23'
redirect_from:
- content/javascript-mandelbrot-browser/
- node/4330/
- import_node/359/
- node/359/
tags:
- Programming
- Mandelbrot
- Javascript
---

I was inspired by my recent attempt at creating a [parallel Mandelbrot generator for Minnow](/import_node/353) to learn some javascript and make a javascript version of it. [Here](/javascript-mandelbrot.html) is an actual example of this code in use. The javascript itself is pretty simple: 

```javascript
function point(t_x, t_y)
{
  this.x = t_x;
  this.y = t_y;
}
function color(t_r, t_g, t_b)
{
  this.r = t_r;
  this.g = t_g;
  this.b = t_b;   
}

function get_color(t_point, t_center, t_width, t_height, t_scale)
{
  var xscaled = t_point.x/(t_width/t_scale) + (t_center.x - (t_scale/2.0 ));
  var yscaled = t_point.y/(t_height/t_scale) + (t_center.y - (t_scale/2.0 ));

  var x = xscaled;
  var y = yscaled;

  var iteration = 0;
  var max_iteration = 2000;

  var stop_iteration = max_iteration;

  while ( iteration < stop_iteration )
  {
    if ((x*x) + (y*y) > (2.0*2.0) && stop_iteration == max_iteration)
    {
      stop_iteration = iteration + 5
    }
     
    var xtemp = (x*x) - (y*y) + xscaled;
    y = (2.0*x*y) + yscaled;
    x = xtemp;
    iteration += 1
  }

  if (iteration == max_iteration)
  {
    return new color(0.0,0.0,0.0)
  } else {
    var value = ((iteration + 1) - (Math.log(Math.log(Math.abs(x * y))))/Math.log(2.0)); 
    var red = 0.0;
    var green = 0.0;
    var blue = 0.0;

    var colorval = Math.floor(value * 10.0);

    if (colorval < 256)
    {
      red = colorval/256.0;
    } else {
      colorband = Math.floor((colorval - 256) % 1024 / 256);
      mod256 = colorval % 256;
      if (colorband == 0)
      {
        red = 1.0;
        green = mod256 / 255.0;
        blue = 0.0;
      } else if (colorband == 1) {
        red = 1.0;
        green = 1.0;
        blue = mod256 / 255.0;
      } else if (colorband == 2) {
        red = 1.0;
        green = 1.0;
        blue = 1.0 - (mod256/255.0);
      } else {
        red = 1.0;
        green = 1.0 - (mod256/255.0);
        blue = 0.0;
      }
    }
    return new color(red, green, blue);
  }
}

function region_calc(t_tl, t_br, t_width, t_height, t_center, t_scale, t_context)
{
  for (var y = t_tl.y; y < t_br.y; y++)
  {
    for (var x = t_tl.x; x < t_br.x; x++)
    {
      var p = new point(x,y);
      set_pixel(p, get_color(p, t_center, t_width, t_height, t_scale), t_context);
    }
  }
}

function set_pixel(t_point, t_color, t_context)
{
  t_context.fillStyle = "rgb("+Math.floor(t_color.r*255)+","+Math.floor(t_color.g*255)+","+Math.floor(t_color.b*255)+")";
  t_context.fillRect(t_point.x, t_point.y, 1, 1);
}

function draw() 
{
  var m_width = document.getElementById("width").value;
  var m_height = document.getElementById("height").value;
  var m_x = document.getElementById("xloc").value;
  var m_y = document.getElementById("yloc").value;
  var m_scale = document.getElementById("scale").value;

  var canvas = document.getElementById("canvas");
  canvas.width = m_width;
  canvas.height = m_height;
  var ctx = canvas.getContext("2d");
  region_calc(new point(0,0), new point(m_width, m_height), m_width, m_height, new point(m_x, m_y), m_scale, ctx);
}
```

