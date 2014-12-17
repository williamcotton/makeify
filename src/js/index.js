var React = require("react");
var App = require("../jsx/app.jsx");
React.initializeTouchEvents(true);
React.renderComponent(App(options), document.getElementById('content'));