import axios from 'axios';
import getCsrfToken from '../../utils/getCsrtToken';
import * as QueryStringForRails from './QueryStringForRails';

const axiosConfig = {
  headers: {
    'X-CSRF-Token': getCsrfToken(),
    'X-Requested-With': 'XMLHttpRequest',
  },
  withCredentials: true,
  paramsSeializer: params => QueryStringForRails.stringify(params),
};

export default axios.create(axiosConfig);
