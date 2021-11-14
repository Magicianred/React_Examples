# Functional Component in Typescript

import FC from react package and extends this type.
Without FC you cannot use Hooks in your component.

- Without props or state

```typescript
import React, { FC } from 'react';

const MyFunctionalComponent : FC = () => {
    return <div>My functional component</div>;
}

export default MyFunctionalComponent;
```

- Only with props

```typescript
import React, { FC } from 'react';

interface MyComponentProps {
    prop1?: string
}

const MyFunctionalComponent : FC<MyComponentProps> = (
    {name}: GreetingProps
) => {
    return <div>My functional component</div>;
}

export default MyFunctionalComponent;
```