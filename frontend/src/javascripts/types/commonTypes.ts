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
  originalList: List;
}

export interface List {
  id: number;
  user_id: number;
  content: string;
  user_count: number;
}

export interface CurrentUserInfo {
  isLoggedIn: boolean;
}
