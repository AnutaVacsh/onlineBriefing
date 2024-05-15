import { redirect, useNavigate } from 'react-router-dom';
import { UserContext } from '../context/UserComtext'
import { useContext, useState } from 'react';
import "../css/login.css"

function Login(){
    let {setUserContext} = useContext(UserContext);
    const [status, setStatus] = useState('student');
    const [position, setPosition] = useState('right');


    const data = {
        username: "",
        password: ""
    };

    function changeStatus(e) {
        e.preventDefault();

        if(status == 'student'){
            setStatus('teacher')
            setPosition('left')
        }
        else{
            setStatus('student')
            setPosition('right')
        }
    }

    function checkLoginStudent(e){
        checkLogin(e)
    }

    function checkLoginTeacher(e){
        checkLogin(e)
    }

    function c(check){
        if(check && check != -1){
            console.log("+")
            setUserContext('user', check);
            status == 'student' ? window.location.href = "/student" : window.location.href = "/teacher";
        }
        else alert("Неправильный логин или пароль");
    }

    function checkLogin(e){
        e.preventDefault();
        console.log(data.username + " " + data.password);
        let check; //либо id либо -1

        if(data.username && data.password)
        fetch("http://localhost:8080//briefing//login/"+status, {
            // mode: 'cors',
            method: "POST",
            headers: {"Content-Type":"application/json"},
            body: JSON.stringify(data.username)
        })
        .then(data => console.log(data))
        .then(data => {if (data.ok) c(data.json())})
        .then(()=>{console.log("check login")})
        .catch((e)=> console.log(e.message));

        else alert("Введите логин и пароль")
    }

    

    return(
        <article>
            <div className={'login shadow '+position}>
                <div className='loginStudent'>
                    <h1>Войти как студент</h1>
                    <div className="form">
                        <div className="loginS">
                            <p>Username</p>
                            <input type="text" name="login" onChange={e => {data.username = e.target.value}}/>
                        </div>
                        <div className="password">
                            <p>Password</p>
                            <input type="text" name="password" onChange={e => {data.password = e.target.value}}/>
                        </div>
                    </div>
                    <div className="blueButton">
                        <a href="" className="user" onClick={checkLoginStudent}>Log In</a>
                    </div>
                </div>
                <div className='loginTeacher'>
                    <h1>Войти как преподаватель</h1>
                    <div className="form">
                        <div className="loginT">
                            <p>Username</p>
                            <input type="text" name="login" onChange={e => {data.username = e.target.value}}/>
                        </div>
                        <div className="password">
                            <p>Password</p>
                            <input type="text" name="password" onChange={e => {data.password = e.target.value}}/>
                        </div>
                    </div>
                     <div className="blueButton">
                            <a href="" className="user" onClick={checkLoginTeacher}>Log In</a>
                        </div>
                </div>
                {/* <div className={'blueBlock '+' kfkfk'}> */}
                <div className={'blueBlock '}>
                    <h1>{status == 'student' ? "Я преподаватель" : "Я студент"}</h1>
                    <div className="blueButton">
                        <a href="" className="user" onClick={changeStatus}>Log In</a>
                    </div>
            </div>
            </div>
            
        </article>
    )
}

export default Login;