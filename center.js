// Javascript to center the Processing.js canvas on screen after dynamically setting the size.
center = function() {
  var container = document.getElementById("content");
  var sketch = document.getElementById("sonone");
  console.log(container);
  console.log(sketch); 
  sketch.style.marginLeft = (( container.offsetWidth - sketch.offsetWidth )/2)+"px";
  sketch.style.marginTop = (( container.offsetHeight - sketch.offsetHeight )/2)+"px";
}


