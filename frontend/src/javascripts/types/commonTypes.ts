export interface Mylist {
  id: number;
  user_id: number;
  list_id: number;
  active: boolean;
  check: boolean;
  strong: boolean;
  check_count: number;
  running_days: number;
  max_running_days: number;
}

export interface CurrentUserInfo {
  isLoggedIn: boolean;
}