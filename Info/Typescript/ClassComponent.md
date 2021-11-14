# Class Component in Typescript

you have to import React
you have to create an interface for the Props and another for the state and pass them as generics to the class React.Component

```typescript
import React from 'react';

interface MyComponentProps {
    prop1: string,
    prop2: number,
    nullableProp?: date
}

interface MyComponentState {
    state1: string,
    state2: number
}

class MyComponent extends React.Component<MyComponentProps, MyComponentState> {
    constructor(props: MyComponentProps) {
        super(props);
        this.state = {
            state1: 'a string into state',
            state2: 123
        }
    }

    render() {
        return <div>
            <span>message: {this.props.prop1}</span>
            <span>number: {this.state.state2.toString()}</span>
        </div>
    }
}

export default MyComponent;
```

## using livecycle

```typescript
import React from 'react';

interface MyComponentProps {
    prop1: string,
    prop2: number,
    nullableProp?: date
}

interface MyComponentState {
    state1: string,
    state2: number
}

class MyComponent extends React.Component<MyComponentProps, MyComponentState> {
    constructor(props: MyComponentProps) {
        super(props);
        this.state = {
            state1: 'a string into state',
            state2: 123
        }
    }
    state: MyComponentState;

    static getDerivedStateFromProps(props: MyComponentProps, state: MyComponentState) {
        console.log(props, state);
        return state;
    }

    render() {
        return <div>
            <span>message: {this.props.prop1}</span>
            <span>number: {this.state.state2.toString()}</span>
        </div>
    }
}

export default MyComponent;
```

## function event

```typescript
onChange(e: React.ChangeEvent<HTMLInputElement>) {
    this.setState({
        state1: e.target.value
    });
}
```