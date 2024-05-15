import Login from "./component/Login";
import "./css/index.css"
import { Routes, Route} from 'react-router-dom';
import { UserContext } from "./context/UserComtext";
import { useState } from "react";
import Student from "./component/student/Student";
import Teacher from "./component/teacher/Teacher";


function App() {
  //сохранение статуса пользователя
  const [status, setStatus] = useState(sessionStorage.getItem('status'));

  //сохранение id пользователя
  const [idUser, setIdUser] = useState(sessionStorage.getItem('idUser'));

  //сохранение id пользователя
  const [name, setName] = useState(sessionStorage.getItem('name'));

  const setUserContext = (id, name, status) => {
    setStatus(status);
    sessionStorage.setItem('status', status);

    setIdUser(id);
    sessionStorage.setItem('idUser', id)

    setName(name);
    sessionStorage.setItem('name', name)
  }

  return(
    

    <>
      <UserContext.Provider value={{status, name, idUser, setUserContext}}>
        <Routes>
          <Route path='/' element = {<Login />}/>
          <Route path="/student/*" element = {(status == 'student' && <Student/>) || (<p>СТРАНИЦА НЕДОСТУПНА</p>)}/>
          <Route path="/teacher/*" element = {(status == 'teacher' && <Teacher/>) || (<p>СТРАНИЦА НЕДОСТУПНА</p>)}/>
          <Route path='*' element = {<p>СТРАНИЦА НЕ НАЙДЕНА</p>}/>
        </Routes>
      </UserContext.Provider>
     
    </>
  )
}

export default App;
