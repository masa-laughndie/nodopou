// Stylesheet

/**
 * @example
 *   // Error
 *   import styles from './styles.module.css';
 *   // Ok
 *   import * as styles from './styles.module.css';
 */
declare module '*.module.css' {
  interface Styles {
    [className: string]: string;
  }
  const styles: Styles;
  export = styles;
}

declare module '*.module.scss' {
  interface Styles {
    [className: string]: string;
  }
  const styles: Styles;
  export = styles;
}

/**
 * @example
 *   // Error
 *   import * as styles from './styles.css';
 *   // Ok
 *   import './styles.css';
 */
declare module '*.css' {
  const nothing: never;
  export = nothing;
}

declare module '*.scss' {
  const nothing: never;
  export = nothing;
}

// JSON

declare module '*.json' {
  const data: any;
  export = data;
}

// Media

declare module '*.jpg' {
  const uri: string;
  export = uri;
}

declare module '*.jpeg' {
  const uri: string;
  export = uri;
}

declare module '*.gif' {
  const uri: string;
  export = uri;
}

declare module '*.png' {
  const uri: string;
  export = uri;
}

declare module '*.svg' {
  const uri: string;
  export = uri;
}

declare module '*.woff' {
  const uri: string;
  export = uri;
}

declare module '*.ttf' {
  const uri: string;
  export = uri;
}

declare module '*.wav' {
  const uri: string;
  export = uri;
}

declare module '*.mp3' {
  const uri: string;
  export = uri;
}

declare module 'jquery';
declare module 'classnames';
declare module 'qs';
