Function.prototype.bind = function(scope) {
  var _function = this;
  
  return function() {
    return _function.apply(scope, arguments);
  }
}

function map(array, fn) {
  var results = [];

  for ( var i = 0; i < array.length; i += 1 ) {
    results.push(fn(array[i]));
  }

  return results;
}

function collect(array, fn) {
  var result = [];

  for ( var i = 0; i < array.length; i += 1 ) {
    var item = array[i];
    if ( fn(item) ) {
      result.push(item);
    }
  }

  return result;
}

function find(array, fn) {
  var result = [];

  for ( var i = 0; i < array.length; i += 1 ) {
    var item = array[i];
    if ( fn(item) ) {
      result.push(item);
    }
  }

  return result;
}

function unique(array) {
  var counts = {};

  for ( var i = 0; i < array.length; i += 1 ) {
    var item = array[i];
    if ( 'undefined' === typeof counts[item] ) {
      counts[item] = 1;
    } else {
      counts[item] += 1;
    }
  }

  var results = [];
  for ( var key in counts ) {
    results.push(key);
  }

  return results;
}

function defineEventHandler(target, event, fn) {
  if ( target.addEventListener ) {
    target.addEventListener(event, fn, false);
  } else if ( target.attachEvent ) {
    target.attachEvent('on' + event, fn);
  } else {
    target['on' + event] = fn;
  }
}

var NumberLocator = {
  numbers: [],
  initialize: function() {
    var numbers_request = new XMLHttpRequest();
    numbers_request.onreadystatechange = function() {
      if ( numbers_request.readyState == 4 ) {
        if ( numbers_request.status == 200 ) {
          NumberLocator.numbers = JSON.parse(numbers_request.responseText);
          NumberLocator.numbers_loaded();
        } else {
          alert('Couldn\'t load access numbers.');
        }
      }
    };
    numbers_request.open('GET', '/numbers.json');
    numbers_request.send();
  },

  numbers_loaded: function() {
    var loading_notice = document.getElementById('loading_notice');
    loading_notice.setAttribute('style', 'display:none;');

    var root = document.getElementById('number_locator_root');
    root.removeAttribute('style');
    
    document.getElementById('number_locator_select').appendChild(NumberLocator.state_select());
    NumberLocator.update_table_for_state(this.states()[0]);
  },

  update_table_for_state: function(state) {
    var table_div = document.getElementById('number_locator_table');
    table_div.innerHTML = '';
    table_div.appendChild(this.table_for_state(state));
  },

  table_for_state: function(state) {
    var table = document.createElement('table');

    var thead = document.createElement('thead');
    var tr = document.createElement('tr');

    var th = document.createElement('th');
    th.textContent = "City";
    tr.appendChild(th);

    var th = document.createElement('th');
    th.textContent = "Access Number";
    tr.appendChild(th);

    thead.appendChild(tr);
    table.appendChild(thead);

    var state_numbers = this.numbers_for_state(state).sort(function(a,b) { 
      if ( a["City"].toLowerCase() < b["City"].toLowerCase() ) {
        return -1;
      } else { 
        return 1;
      }
    });
    var tbody = document.createElement('tbody');
    for ( var i = 0; i < state_numbers.length; i += 1 ) {
      var number = state_numbers[i];
      var tr = document.createElement('tr');

      var td = document.createElement('td');
      td.textContent = number["City"];
      tr.appendChild(td);

      var td = document.createElement('td');
      td.textContent = number["Access Number"];
      tr.appendChild(td);

      tbody.appendChild(tr);
    }

    table.appendChild(tbody);
    return table;
  },

  numbers_for_state: function(state) {
    return find(this.numbers, function(item) { return item["State"] === state; });
  },

  state_select: function() {
    var select = document.createElement('select');
    select.setAttribute('id', 'number_locator_state_select');

    var states = this.states();
    for ( var i = 0; i < states.length; i += 1 ) {
      var state = states[i];

      var option = document.createElement('option');
      option.setAttribute('value', state);
      option.textContent = state;

      select.appendChild(option);
    }

    defineEventHandler(select, 'change', this.handle_state_changed);

    return select;
  },

  states: function() {
    return unique(map(this.numbers, function(item) { return item["State"]; })).sort();
  },

  handle_state_changed: function(event) {
    var selected_state = document.getElementById('number_locator_state_select').value;
    NumberLocator.update_table_for_state(selected_state);
  }
};

function bindObjectFunctions(object) {
  for ( var key in object ) {
    if ( 'function' === typeof object[key] ) {
      object[key].bind(object);
    }
  }
}
bindObjectFunctions(NumberLocator);
