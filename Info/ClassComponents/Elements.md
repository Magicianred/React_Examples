# Elementi di React  
L'elemento principale e di base di React sono i *component*.  
Ci sono diversi tipi di componenti, ognuno ha caratteristiche diverse ed è più o meno indicato ad un certo scopo.  

## Component Types  
* [Functional Component](#functional-component)  
    * [React Hook](#react-hook)  
        * [UseEffect()](#use-effect)  
        * [Custom Hook](#custom-hook)  
* [Class Component](#class-component)  
* [Container Component](#container-component)  
* [Higher-Order Component](#higher-order-component)  
    * [With Recompose Library](#with-recompose-library)  
* [Render Prop Component](#render-prop-component)  

### Functional Component  
I *Functional Stateless* Component o *Stateless* Component sono una funzione standard javascript, componenti senza *State*.  
Aggiungendo i *React Hook*s si hanno i Functional Component.

```javascript
import React from 'react';

const FunctionalComponent = props =>
    <div>
        <h1>Functional Component</h1>
        <p>{props.message}</p>
    </div>

export default FunctionalComponent;
```  

oppure  

```javascript
import React from 'react';

const FunctionalComponent = (props) => {
    const message = props.message;

    return (
        <div>
            <h1>Functional Component</h1>
            <p>{message}</p>
        </div>
    )
}

export default FunctionalComponent;
```  

#### React Hook  
Con i *React Hook* i *Functional Component* possono avere lo *State*  

```javascript
import React from 'react';

const FunctionalHookComponent = (props) => {
    const message = props.message;

    const [value, setValue] = React.useState('');

    const onChange = event => setValue(event.target.value);

    return (
        <div>
            <h1>Functional Hook Component</h1>
            <p>{message}</p>

            <input value="{value}" type="text" onChange={onChange} />

            <p>{value}</p>
        </div>
    )
}

export default FunctionalHookComponent;
```

##### Use Effect  
Gli *Effect*s sono scatenati quando un *useState* è invocato e provocano degli "effetti"  

```javascript
import React from 'react';

const FunctionalHookComponent = (props) => {
    const message = props.message;

    const [value, setValue] = React.useState(
        localStorage.getItem('myValueInLocalStorage') || '',
    );
    
    React.useEffect(() => {
        localStorage.setItem('myValueInLocalStorage', value);
    }, [value]);

    const onChange = event => setValue(event.target.value);

    return (
        <div>
            <h1>Functional Hook Component</h1>
            <p>{message}</p>

            <input value="{value}" type="text" onChange={onChange} />

            <p>{value}</p>
        </div>
    )
}

export default FunctionalHookComponent;
```

##### Custom Hook  
Questa è una modalità simile ai *Mixins*, agli *HOC*s e ai *Render Prop Component*s per separare parti di logica e riutilizzarla su più componenti.  

```javascript
import React from 'react';

const useStateWithLocalStorage = localStorageKey => {
  const [value, setValue] = React.useState(
    localStorage.getItem(localStorageKey) || '',
  );
 
  React.useEffect(() => {
    localStorage.setItem(localStorageKey, value);
  }, [value]);
 
  return [value, setValue];
};

const FunctionalHookComponent = (props) => {
    const message = props.message;

    const [value, setValue] = useStateWithLocalStorage(
        'myValueInLocalStorage',
    );

    const onChange = event => setValue(event.target.value);

    return (
        <div>
            <h1>Functional Hook Component</h1>
            <p>{message}</p>

            <input value="{value}" type="text" onChange={onChange} />

            <p>{value}</p>
        </div>
    )
}

export default FunctionalHookComponent;
```

### Class Component  
Si usa quando c'è necessità di manipolare lo *State*.  
E' un oggetto javascript standard.  

```javascript
import React, { Component } from 'react';  

class ClassComponent extends Component {
    constructor(props) {
        super(props);

        // initialize state
        this.state = { 
            message: props.message || '',
            value: localStorage.getItem('myValueInLocalStorage') || '',
        };

        // bind methods
        this.onChange = this.onChange.bind(this);
    }

    componentDidUpdate() {
        localStorage.setItem('myValueInLocalStorage', this.state.value);
    }
    
    // auto-bind method
    onChangeAutoBind = event => {
        this.setState({ value: event.target.value });
    };
 
    onChange(event) {
        this.setState({ value: event.target.value });
    }

    render() {
        <div>
            <h1>Class Component</h1>
            <p>{this.state.message}</p>
 
            <input
                value={this.state.value}
                type="text"
                onChange={this.onChange}
                />
    
            <p>{this.state.value}</p>
        </div>
    }
}

export default ClassComponent;
```  

### Container Component  
Il *Container Component* è un regolare *Class Component* con la possibilità di connettere un *Redux* via connect() method  

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

### Higher-Order Component  
*React Higher-Order* Component (HOCs) sono un'alternativa ai *React Mixins* (deprecati) per riutilizzare logiche nei componenti react.  
Per brevità i HOCs sono componenti che prendono in input un componente e ritornano un componente con in più le funzionalità impostate nell'HOCs.  

```javascript
import React from 'react';

const withHOCs = localStorageKey => Component =>
    class WithHOCs extends React.Component {
        constructor(props) {
            super(props);

            this.state = {
                [localStorageKey]: localStorage.getItem(localStorageKey),
            };
        }

        setLocalStorage = value => {
            localStorage.setItem(localStorageKey, value);
        }

        render() {
            return (
                <Component
                    {...this.state}
                    {...this.props}
                    setLocalStorage={this.setLocalStorage}
                    />
            );
        }
    };

class OtherComponent extends React.Component {
    constructor(props) {
        super(props);

        this.state = { value: this.props['myValueInLocalStorage'] || '' };
    }

    componentDidUpdate() {
        this.props.setLocalStorage(this.state.value);
    }
 
    onChange = event => {
        this.setState({ value: event.target.value });
    };

    
    render() {
        return (
        <div>
            <h1>
                Higher-Order Component!
            </h1>
    
            <input  value={this.state.value}
                type="text" onChange={this.onChange} />
    
            <p>{this.state.value}</p>
        </div>
        );
    }
}

const OtherComponentWithHOCs = withHOCs('myValueInLocalStorage')(OtherComponent);
```

#### With Recompose Library  
Per utilizzare più HOCs in maniera più leggibile utilizzare la libreria [*recompose*](https://github.com/acdlite/recompose)  

```javascript
import React from 'react';
import { compose } from 'recompose'

const withFunction1 = (Component) => (props) = [ ... ];
const withFunction2 = (Component) => (props) = [ ... ];

const App = compose(
    withFunction1,
    withFunction2,
);

export default App;
```

### Render Prop Component  
*React Render Prop* Component è un'alternativa agli Higher-Order Component (HOCs).  
Conosciuto anche come *Children as a function* o *child as a function*.  

```javascript
import React from 'react';

const RenderPropComponent = props => <div>{props.children}</div>;

const App = props => <RenderPropComponent><Component1 /><Component2 /></RenderPropComponent>;

const Component1 = () => <p>Componente 1</p>;
const Component2 = () => <p>Componente 2</p>;

export default App;
```

