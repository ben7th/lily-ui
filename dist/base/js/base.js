(function() {


}).call(this);

(function() {
  jQuery((function(_this) {
    return function() {
      var component_name, constructor, dom, i, len, props, ref, results;
      ref = jQuery('[data-react-class]');
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        dom = ref[i];
        component_name = dom.getAttribute('data-react-class');
        constructor = _this[component_name] || eval.call(_this, component_name);
        props = {
          a: 1
        };
        results.push(ReactDOM.render(React.createElement(constructor, props), dom));
      }
      return results;
    };
  })(this));

}).call(this);

(function() {
  console.log(2);

}).call(this);

//# sourceMappingURL=base.js.map
