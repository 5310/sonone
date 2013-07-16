/*this.css("position","absolute");
this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + 
                                            $(window).scrollTop()) + "px");
this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
                                            $(window).scrollLeft()) + "px");*/
                                            

center = function() {
  var container = document.getElementById("content");
  var sketch = document.getElementById("sonone");
  console.log(container);
  console.log(sketch); 
  sketch.style.marginLeft = (( container.offsetWidth - sketch.offsetWidth )/2)+"px";
  sketch.style.marginTop = (( container.offsetHeight - sketch.offsetHeight )/2)+"px";
}


