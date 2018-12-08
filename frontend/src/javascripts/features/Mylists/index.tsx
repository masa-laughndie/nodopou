import * as React from 'react';
import { Mylist } from '../../types/commonTypes';

interface Props {
  mylists: Mylist[];
}

class Mylists extends React.Component<Props> {
  public render() {
    return <div>Mylists</div>;
  }
}

export default Mylists;
