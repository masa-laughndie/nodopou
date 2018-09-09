import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { Hello } from './components/Hello';

ReactDOM.render(
  <Hello message="Hello, World!" />,
  document.querySelector('[data-react-entry="root"]')
);
