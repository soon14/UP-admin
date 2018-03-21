import {toast} from 'react-toastify'

export const API_URL = "/api/v1/"
export const NOTIFY_LEVEL = {
    DEFAULT: toast.TYPE.DEFAULT,
    SUCCESS: toast.TYPE.SUCCESS,
    ERROR: toast.TYPE.ERROR,
    WARNING: toast.TYPE.WARNING,
    INFO: toast.TYPE.INFO
}
export const NOTIFY_TEXT = {
    SUCCESS: "Úspěšně uloženo",
    ERROR: "Chyba při ukládání",
    ERROR_LOADING: "Došlo k chybě při načítání dat"
}
export const ATTENDANCESTATE_OK = 5
export const EDIT_TYPE = {
    STATE: 0,
    COURSE: 1
}
