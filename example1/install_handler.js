function install_handler (f) {
  var node = document.createElement("button");
  node.textContent = "Click me!";
  node.onclick = function () {
    var result = f();
    console.log("Clicked " + result + " times");
  };
  document.body.appendChild(node);
}