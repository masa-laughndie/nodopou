import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { Hello } from './components/Hello';

storiesOf('Hello', module).add('default', () => (
  <Hello message="Hello, world!!" />
));
