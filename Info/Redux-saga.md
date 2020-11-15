# Redux-Saga  
redux-saga aiuta a gestire i side effect dell'applicazione (come le chimate asincrone - come data fetch - e cose impure - tipo la gestione della cache del browser -)  
E' come avere un thread separato per gestire solo i side effect  
redux-saga è un middleware redux, è un thread che può essere iniziato, messo in pausa o cancellato dall'applicazione principale con normali redux actions  
rispetto al redux-thunk, per la gestione delle fetch, ti permette di non finire nella callback-hell  

[repo](https://github.com/redux-saga/redux-saga)  

[documentation](https://redux-saga.js.org/docs/introduction/)  

## Basic concepts of Redux-saga  
* [Saga Helpers](#saga-helpers)  
    * [Watcher takeEvery](#watcher-takeEvery)  
    * [Watcher takeLatest](#watcher-takeLatest)  
* [Declarative Effects](#declarative-effects)  
    * [call method](#call-method)  
    * [apply method](#apply-method)  
    * [cps method](#cps-method)
* [Dispatching actions](#dispatching-actions)  
    * [put method](#put-method)  
* [Error handling](#error-handling)  
* [Effect](#effect)  

### Saga Helpers  
redux-saga provides some helper effects wrapping internal functions to spawn tasks when some specific actions are dispatched to the Store.  
this is a similar effect of *redux-thunk*  

#### Watcher takeEvery  

First we create the task that will perform the asynchronous action:  
```javascript
import { call, put } from 'redux-saga/effects';

export function* fetchData(action) {
    try {
        const data = yield call(Api.fetchUser, action.payload.url);
        yield put({ type: "FETCH_SUCCEDED", data });
    } catch (error) {
        yield put({ type: "FETCH_FAILED", error });
    }
}
```

To launch the above task on *each* FETCH_REQUESTED action:  
```javascript
import { takeEvery } from 'redux-saga/effects';

function* watchFetchData() {
    yield takeEvery('FETCH_REQUESTED', fetchData);
}
```
#### Watcher takeLatest  
To launch the above task on *the last* FETCH_REQUESTED action:  
```javascript
import { takeLatest } from 'redux-saga/effects';

function* watchFetchData() {
    yield takeLatest('FETCH_REQUESTED', fetchData);
}
```
### Declarative Effects  
In redux-saga, Sagas are implemented using Generator functions. To express the Saga logic, we yield plain JavaScript Objects from the Generator. We call those Objects Effects. An Effect is an object that contains some information to be interpreted by the middleware. You can view Effects like instructions to the middleware to perform some operation (e.g., invoke some asynchronous function, dispatch an action to the store, etc.).  

#### call method
similar function is *apply* and *cps* (continuation passing style - for node function)  

```javascript
import { call } from 'redux-saga/effects'

function* fetchProducts() {
  const products = yield call(Api.fetch, '/products')
  // ...
}
```
#### apply method
similar function is *call*

```javascript
import { apply } from 'redux-saga/effects'

function* fetchProducts() {
  const products = yield apply(Api.fetch, '/products')
  // ...
}
```
#### cps method
similar function is *apply* and *cps* (continuation passing style)  

```javascript
import { cps } from 'redux-saga/effects'

const content = yield cps(readFile, '/path/to/file')
```

### Dispatching actions  
Taking the previous example further, let's say that after each save, we want to dispatch some action to notify the Store that the fetch has succeeded (we'll omit the failure case for the moment).  

#### put method
For notify a return AJAX to the store we use *put* function  

```javascript
import { call, put } from 'redux-saga/effects'
// ...

function* fetchProducts() {
  const products = yield call(Api.fetch, '/products')
  // create and yield a dispatch Effect , in place of *dispatch({ type: 'PRODUCTS_RECEIVED', products })*
  yield put({ type: 'PRODUCTS_RECEIVED', products })
}
```

### Error handling  
In this section we'll see how to handle the failure case from the previous example. Let's suppose that our API function Api.fetch returns a Promise which gets rejected when the remote fetch fails for some reason.  

We want to handle those errors inside our Saga by dispatching a PRODUCTS_REQUEST_FAILED action to the Store.  

We can catch errors inside the Saga using the familiar try/catch syntax.  

```javascript
import Api from './path/to/api'
import { call, put } from 'redux-saga/effects'

// ...

function* fetchProducts() {
  try {
    const products = yield call(Api.fetch, '/products')
    yield put({ type: 'PRODUCTS_RECEIVED', products })
  }
  catch(error) {
    yield put({ type: 'PRODUCTS_REQUEST_FAILED', error })
  }
}
```

oppure  

```javascript
import Api from './path/to/api'
import { call, put } from 'redux-saga/effects'

function fetchProductsApi() {
  return Api.fetch('/products')
    .then(response => ({ response }))
    .catch(error => ({ error }))
}

function* fetchProducts() {
  const { response, error } = yield call(fetchProductsApi)
  if (response)
    yield put({ type: 'PRODUCTS_RECEIVED', products: response })
  else
    yield put({ type: 'PRODUCTS_REQUEST_FAILED', error })
}
```

