import * as React from 'react';

interface HelloProps {
  message: string;
}

const Hello = (props: HelloProps) => {
  return <div>{props.message}</div>;
};

export { Hello };
