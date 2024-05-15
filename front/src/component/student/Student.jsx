import { Routes, Route, Link, Outlet} from 'react-router-dom';
import { UserContext } from '../../context/UserComtext'
import { useContext, useState } from 'react';
import Login from '../Login';
import '../../css/student.css'
import ListBriefingSt from './ListBriefingSt';
import { StateStudentContext } from '../../context/StateStudentContext';
import Progress from './Progress';
import News from './News';
import Statistics from './Statistics';
import BriefingSt from './BriefingSt';
import TestSt from './TestSt';
import Result from './Result';

function Student(){
    const [activeLink, setActiveLink] = useState(1);
    const [openNavPanel, setOpenNavPanel] = useState(true);
    const [state, setState] = useState({idSubject: null, idBriefing: null});
    let {name} = useContext(UserContext);

    function home(){
        window.location.href = '/';
    }

    return(
        <article className='student'>
            <div className={'blueNavPanel '+ (openNavPanel ? "": "close")}>
                <div className='profile'>
                    <img src={require('../../img/student.png')} />
                    <p>{name}</p>
                </div>
                <nav>
                    <Link to="/student" className={'navStudent' + ' ' + (activeLink === 1? "active": "")} onClick={() => setActiveLink(1)}>Летучки</Link>
                    <Link to="/student/progress" className={'navStudent' + ' ' + (activeLink === 2? "active": "")} onClick={() => setActiveLink(2)}>Прогресс</Link>
                    <Link to="/student/statistics" className={'navStudent' + ' ' + (activeLink === 3? "active": "")} onClick={() => setActiveLink(3)}>Статистика</Link>
                    <Link to="/student/news" className={'navStudent' + ' ' + (activeLink === 4? "active": "")} onClick={() => setActiveLink(4)}>Объявления</Link>
                    <Outlet/>
                </nav>
                <div className={'home ' + (openNavPanel ? "": "active")}  onClick={home}>Выход</div>
                <div className='closeMenu' onClick={() => setOpenNavPanel(false)}></div>
            </div>
            <div className='page'>
                <StateStudentContext.Provider value={{state, setState}}>
                    <Routes >
                        <Route path='/' element = {<ListBriefingSt />}/>
                        <Route path='/progress' element = {<Progress/>}/>
                        <Route path='/statistics' element = {<Statistics/>}/>
                        <Route path='/news' element = {<News/>}/>
                        <Route path='/briefing' element = {<BriefingSt/>}/>
                        <Route path='/briefing/test' element = {<TestSt/>}/>
                        <Route path='/briefing/result' element = {<Result/>}/>
                        <Route path='*' element = {<p>СТРАНИЦА НЕ НАЙДЕНА</p>}/>
                    </Routes>
                </StateStudentContext.Provider>
                
                <div className={'menu ' + (openNavPanel ? "": "active")}  onClick={() => setOpenNavPanel(true)}></div>
            </div>
            
        </article>
    )
}

export default Student;