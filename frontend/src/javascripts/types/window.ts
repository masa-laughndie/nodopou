export interface GonMylist {
  id: number;
  user_id: number;
  list_id: number;
  active: boolean;
  check: boolean;
  strong: boolean;
  check_count: number;
  running_days: number;
  max_running_days: number;
  originalList: GonList;
}

export interface GonList {
  id: number;
  user_id: number;
  content: string;
  user_count: number;
}

export interface GonCurrentUserInfo {
  isLoggedIn: boolean;
}

export interface Gon {
  mylists: GonMylist[];
  currentInfo: GonCurrentUserInfo;
}
