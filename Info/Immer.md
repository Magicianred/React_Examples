# Immer  
German for *always*

[documentation](https://immerjs.github.io/immer/docs/introduction)

## Redux-Immer  
redux-immer - Redux combineReducers immer-aware!  
redux-immer is used to create an equivalent function of Redux combineReducers that works with immer state.  
Like redux-immutable but for immer  

[documentation](https://github.com/salvoravida/redux-immer)

```javascript
import produce from "immer"

const baseState = [
    {
        todo: "Learn typescript",
        done: true
    },
    {
        todo: "Try immer",
        done: false
    }
]

const nextState = produce(baseState, draftState => {
    draftState.push({todo: "Tweet about it"})
    draftState[1].done = true
})
```

### Producer  
The producer function receives one argument, the draft, which is a proxy to the current state you passed in. Any modification you make to the draft will be recorded and used to produce nextState. The currentState will be untouched during this process.  

```javascript
import produce from "immer"

const nextState = produce(currentState, draft => {
  // empty function, return the original state
})

console.log(nextState === currentState) // true
```

#### Example of immutable object, like a state  

```javascript
import produce from "immer"

const todos = [ /* 2 todo objects in here */ ]

const nextTodos = produce(todos, draft => {
    draft.push({ text: "learn immer", done: true })
    draft[1].done = true
})

// old state is unmodified
console.log(todos.length)        // 2
console.log(todos[1].done)       // false

// new state reflects the draft
console.log(nextTodos.length)    // 3
console.log(nextTodos[1].done)   // true

// structural sharing
console.log(todos === nextTodos)       // false
console.log(todos[0] === nextTodos[0]) // true
console.log(todos[1] === nextTodos[1]) // false
```

#### Example of reducer (redux) and an Immer reducer  

```javascript
const byId = (state, action) => {
  switch (action.type) {
    case RECEIVE_PRODUCTS:
      return {
        ...state,
        ...action.products.reduce((obj, product) => {
          obj[product.id] = product
          return obj
        }, {})
      }
    default:      
      return state
  }
}
```

```javascript
const byId = (state, action) =>
  produce(state, draft => {
    switch (action.type) {
      case RECEIVE_PRODUCTS:
        action.products.forEach(product => {
          draft[product.id] = product
        })
        break
    }
  })
```

### Currying  
It is possible to call produce with just the producer function. This will create a new function that will execute the producer when it’s passed in a state. This new function also accepts an arbitrary amount of additional arguments and passes them on to the producer.  

```javascript
const byId = produce((draft, action) => {
  switch (action.type) {
    case RECEIVE_PRODUCTS:
      action.products.forEach(product => {
        draft[product.id] = product
      })
      break
  }
})
```