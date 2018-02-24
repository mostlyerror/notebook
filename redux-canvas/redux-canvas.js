
// Get the canvas element
var canvas = document.querySelector('canvas');
// Get the drawing context
var ctx = canvas.getContext('2d');

// Define the initial state
var initialState = {
  canvas: { x: 0, y: 0 },
  items: [
    { x: 10, y: 10, width: 50, height: 50, color: 'red' },
    { x: 30, y: 30, width: 50, height: 50, color: 'blue' }
  ],
  xDragging: null,
  yDragging: null,
  draggingItemId: null
};

// Define how state changes
var reducer = function(state, action) {
  if (typeof state === 'undefined') {
    return initialState;
  }
  switch (action.type) {
    case 'TRANSLATE_CANVAS_START':
      return {
        canvas: state.canvas,
        items: state.items,
        xDragging: action.xDragging,
        yDragging: action.yDragging,
        draggingItemId: null
      };
    case 'TRANSLATE_CANVAS':
      return {
          canvas: {
            x: state.canvas.x + action.xDragging - state.xDragging,
            y: state.canvas.y + action.yDragging - state.yDragging
          },
          item: state.items,
          xDragging: action.xDragging,
          yDragging: action.yDragging,
          draggingItemId: null
      };
    case 'TRANSLATE_CANVAS_END':
      return {
        canvas: state.canvas,
        items: state.items,
        yDragging: null,
        yDragging: null,
        draggingItemId: null
      };
    case 'TRANSLATE_ITEM_START':
      return {
        canvas: state.canvas,
        item: state.items,
        xDragging: action.xDragging,
        yDragging: action.yDragging,
        draggingItemId: action.id
      };
    case 'TRANSLATE_ITEM':
      var newItems = state.items.map(function(item) {
        if (item.id === state.draggingItemId) {
          return {
            id: item.id,
            x: item.x + action.xDragging - state.xDragging,
            y: item.y + action.yDragging - state.yDragging,
            width: item.width,
            height: item.height,
            color: item.color
          };
        } else {
          return item;
        }
      });
      return {
        canvas: state.canvas,
        items: newItems,
        xDragging: action.xDragging,
        yDragging: action.yDragging,
        draggingItemId: state.draggingItemId
      }
    case 'TRANSLATE_ITEM_END':
      return {
        canvas: state.canvas,
        items: state.items,
        xDragging: null,
        yDragging: null,
        draggingItemId: null
      };
    default:
      return state;
  }
};

// Define how state is viewed
var draw = function() {
  // debugger;
  var state = store.getState();
  ctx.setTransform(1, 0, 0, 1, 0, 0);
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.setTransform(1, 0, 0, 1, state.canvas.x, state.canvas.y);
  state.items.forEach(function(item) {
    ctx.fillStyle = item.color;
    ctx.fillRect(item.x, item.y, item.width, item.height);
  });
};

// Create the Redux store
// (to manage state changes)
var store = Redux.createStore(reducer);
store.subscribe(draw);

canvas.addEventListener('mousedown', function(event) {
  var state = store.getState();
  for (var i = state.items.length - 1; i >= 0; i--) {
    var item = state.items[i];
    ctx.beginPath();
    ctx.rect(item.x, item.y, item.width, item.height);
    if (ctx.isPointInPath(event.offsetX, event.offsetY)) {
      store.dispatch({
        type: 'TRANSLATE_ITEM_START',
        id: item.id,
        xDragging: event.offsetX,
        yDragging: event.offsetY
      });
      return;
    }
  }
  store.dispatch({
    type: 'TRANSLATE_CANVAS_START',
    xDragging: event.offsetX,
    yDragging: event.offsetY
  });
}, false);

canvas.addEventListener('mousemove', function(event) {
  var state = store.getState();
  if (state.draggingItemId !== null) {
    store.dispatch({
      type: 'TRANSLATE_ITEM',
      xDragging: event.offsetX,
      yDragging: event.offsetY
    });
  } else if (state.xDragging !== null && state.yDragging !== null) {
    store.dispatch({
      type: 'TRANSLATE_CANVAS',
      xDragging: event.offsetX,
      yDragging: event.offsetY
    });
  }
}, false);

canvas.addEventListener('mouseup', function(event) {
  var state = store.getState();
  if (state.getDraggingItemId !== null) {
    store.dispatch({
      type: 'TRANSLATE_ITEM_END'
    });
  } else {
    store.dispatch({
      type: 'TRANSLATE_CANVAS_END'
    });
  }
}, false);

// Draw the initial view
draw();
