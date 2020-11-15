# REDUX  

## Element Types of Redux  
* [Principles of Redux](#Principles-of-Redux)  
  * [Single Source of Truth](#Single-Source-of-Truth)  
  * [State is Read-only](#State-is-Read-only)  
  * [Changes are made with pure functions](#Changes-are-made-with-pure-functions)  

## Element Types of Redux  
* [Actions](#actions)  
  * [Action Creators](#action-creators)  
    * [Bound action creators](#bound-action-creator)
    * [Action creator function (factory pattern)](#Action-creator-function-(factory-pattern))
* [Reducers](#reducers)  
  * [Designing the State Shape](#Designing-the-State-Shape)
  * [Handling Actions](#Handling-Actions)  
* [Store](#store)  
  * [createStore](#createstore)  
  * [getState](#getState)  
  * [dispatch](#dispatch)  
  * [subscribe](#subscribe)  
* [Example of Container Component (Class Component)](#Example-of-Container-Component-(Class-Component))

### Principles of Redux

#### Single Source of Truth  
The state of your whole application is stored in an object tree within a single store. As whole application state is stored in a single tree, it makes debugging easy, and development faster.  

#### State is Read-only  
The only way to change the state is to emit an action, an object describing what happened. This means nobody can directly change the state of your application.  

#### Changes are made with pure functions  
To specify how the state tree is transformed by actions, you write pure reducers. A reducer is a central place where state modification takes place. Reducer is a function which takes state and action as arguments, and returns a newly updated state.  

### Actions

Actions are payloads of information that send data from your application to your store. They are the only source of information for the store. You send them to the store using store.dispatch().

```javascript
/*
 * action types (il nome dell'azione come costante)
 */
export const ADD_TODO = 'ADD_TODO'
export const TOGGLE_TODO = 'TOGGLE_TODO'
export const SET_VISIBILITY_FILTER = 'SET_VISIBILITY_FILTER'
/*
 * other constants
 */
export const VisibilityFilters = {
  SHOW_ALL: 'SHOW_ALL',
  SHOW_COMPLETED: 'SHOW_COMPLETED',
  SHOW_ACTIVE: 'SHOW_ACTIVE'
}
```

#### Action Creators

Action creators are exactly that—functions that create actions. It's easy to conflate the terms “action” and “action creator”, so do your best to use the proper term.

```javascript
/*
 * action creators (la funzione vera e propria)
 */
export function addTodo(text) {
  return { type: ADD_TODO, text }
}
export function toggleTodo(index) {
  return { type: TOGGLE_TODO, index }
}
export function setVisibilityFilter(filter) {
  return { type: SET_VISIBILITY_FILTER, filter }
}

/*
 * call the action by dispatch
 */
dispatch(addTodo(text))
dispatch(completeTodo(index))
```

##### bound action creator

Alternatively, you can create a bound action creator that automatically dispatches

```javascript
/*
 * bound action creator (opzionali, creano una funzione che usa il dispatch e la funzione stessa)
 */
const boundAddTodo = text => dispatch(addTodo(text))
const boundCompleteTodo = index => dispatch(completeTodo(index))

/*
 * call the bound action creator
 */
boundAddTodo(text)
boundCompleteTodo(index)
```

##### Action creator function (factory pattern)

```javascript
function makeActionCreator(type, ...argNames) {
  return function(...args) {
    const action = { type }
    argNames.forEach((arg, index) => {
      action[argNames[index]] = args[index]
    })
    return action
  }
}
const ADD_TODO = 'ADD_TODO'
const EDIT_TODO = 'EDIT_TODO'
const REMOVE_TODO = 'REMOVE_TODO'
export const addTodo = makeActionCreator(ADD_TODO, 'text')
export const editTodo = makeActionCreator(EDIT_TODO, 'id', 'text')
export const removeTodo = makeActionCreator(REMOVE_TODO, 'id')
```

### Reducers

Reducers specify how the application's state changes in response to actions sent to the store. Remember that actions only describe what happened, but don't describe how the application's state changes.

#### Designing the State Shape

In Redux, all the application state is stored as a single object. It's a good idea to think of its shape before writing any code. What's the minimal representation of your app's state as an object?

For our todo app, we want to store two different things:

The currently selected visibility filter.
The actual list of todos.

#### Handling Actions

Now that we've decided what our state object looks like, we're ready to write a reducer for it. The reducer is a pure function that takes the previous state and an action, and returns the next state.

(previousState, action) => nextState

It's very important that the reducer stays pure. Things you should never do inside a reducer:

Mutate its arguments;
Perform side effects like API calls and routing transitions;
Call non-pure functions, e.g. Date.now() or Math.random().

```javascript
const reducer = (state = initialState, action) => {
   switch (action.type) {
      case 'ITEMS_REQUEST':
         return Object.assign({}, state, {
            isLoading: action.isLoading
         })
      default: // if no action, return invariat state
         return state;
   }
}
```

### Store

The Store is the object that brings them together. The store has the following responsibilities:

- Holds application state;
- Allows access to state via getState();
- Allows state to be updated via dispatch(action);
- Registers listeners via subscribe(listener);
- Handles unregistering of listeners via the function returned by subscribe(listener).

```javascript
import { createStore } from 'redux'
import { Provider } from 'react-redux';
import todoApp from './reducers'
const store = createStore(todoApp)

// base Provider, to access Redux from App and his childs
ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
);
```

#### createStore  
permette di creare uno store redux  

```javascript
import { createStore } from 'redux';
import reducer from './reducers/reducer'
const store = createStore(reducer);

// createStore(reducer, [preloadedState], [enhancer])
```

#### getState  
ritorna lo stato corrente di redux  

```javascript
store.getState()
```

#### dispatch  
permette di scatenare una action per modificare lo stato dell'applicazione  

```javascript
store.dispatch({type:'ITEMS_REQUEST'})
```

#### subscribe  
(if you use react-redux don't use subscribe directly - <Provide store={store}> is used in place of that)
permette di notificare i cambiamenti dello store a seguito delle chiamate alle action e quindi aggiornare le view  

```javascript
store.subscribe(()=>{ console.log(store.getState());})
```

per annullare la sottoscrizione si usa la funzione che ritorna dalla subscribe  
```javascript
const unsubscribe = store.subscribe(()=>{console.log(store.getState());});
unsubscribe();
```

## Example of Container Component (Class Component)

```javascript
import React, { Component } from 'react';
import { connect } from 'react-redux';
import PresentationalComponent from './components/PresentationalComponent';

class App extends Component {
  render() {
    return (
      <div className="main-content">
        <PresentationalComponent tasks={this.props.tasks} />
      </div>
    );
  }
}

// function that map Store state in props for the presentational component
function mapStateToProps(state) {
  // select the data from store that will be used
  return {
    tasks: state.tasks
  }
}

export default connect(mapStateToProps) (App);
```





