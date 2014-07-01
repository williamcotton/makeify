/** @jsx React.DOM */
var React = require("../js/react");
var App = React.createClass({
  render: function() {
  	var name = this.props.name;
  	var description = this.props.description;
  	var dependencies = this.props.dependencies;
  	var dependenciesArray = [];
  	for (var depname in dependencies) {
  		dependenciesArray.push({
  			name: depname,
  			version: dependencies[depname]
  		});
  	}
  	var createDependency = function(dependency, index) {
  		return <li>{dependency.name}</li>;
  	};
    return (
      <div className="app">
      	<h1>{name}</h1>
      	<p>{description}</p>
      	<h2>dependencies</h2>
      	<ul>{dependenciesArray.map(createDependency)}</ul>
      </div>
    );
  }
});
module.exports = App;