import { Mylist } from '../src/javascripts/types/commonTypes';

export const mylist1: Mylist = {
  active: true,
  check: false,
  check_count: 0,
  id: 2,
  list_id: 2,
  max_running_days: 0,
  originalList: {
    content: 'test2',
    id: 2,
    user_count: 1,
    user_id: 1
  },
  running_days: 0,
  strong: false,
  user_id: 1
};

export const mylists: Mylist[] = [mylist1];
