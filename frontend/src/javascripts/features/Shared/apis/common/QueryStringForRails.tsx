import qs from 'qs';

export function stringify(params: Object): string {
  return qs.stringify(params, {
    arrayFormat: 'brackets'
  });
}
