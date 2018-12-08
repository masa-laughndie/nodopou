import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs } from '@storybook/addon-knobs';
import Mylists from '.';
import { mylists } from '../../../../stories/dummyData';

storiesOf('Mylists', module)
  .addDecorator(withKnobs)
  .add('default', () => {
    return <Mylists mylists={mylists} />;
  });
