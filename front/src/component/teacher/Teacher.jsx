import { Routes, Route, Link, Outlet} from 'react-router-dom';
import { UserContext } from '../../context/UserComtext'
import { useContext, useState } from 'react';
import '../../css/student.css'
import '../../css/teacher.css'
import ListBriefingT from './ListBriefingT';
import BriefingT from './BriefingT';
import { StateTeacherContext } from '../../context/StateTeacherContext ';
import InsideBriefingT from './InsideBriefingT';
import InsideBriefingStudentT from './insideBriefingStudentT';
import AnaliticsHome from './AnaliticsHome';
import StudentGroup from '../analitics/StudentGroup'
import Chart from '../analitics/StudentGroup'
import NewBriefing from './NewBriefing';
import Effectiveness from '../analitics/Effectiveness';
import UntestedBriefingList from './UntestedBriefingList';
import UntestedSubject from './UntestedSubject';
import PageUntested from './PageUntested';
import Anomalies from '../analitics/Anomalies';
import Statistics from './Statistics';
import NewsT from './NewsT'
import Questions from '../analitics/Questions';

function Teacher(){
    const [activeLink, setActiveLink] = useState();
    const [openNavPanel, setOpenNavPanel] = useState(true);
    const [state, setState] = useState({idSubject: null, idBriefing: null});
    let {name} = useContext(UserContext);

    function home(){
        window.location.href = '/';
    }

    return(
        <article className='teacher'>
            <div className={'blueNavPanel '+ (openNavPanel ? "": "close")}>
                <div className='profile'>
                    <img src={require('../../img/teacher.png')} />
                    <p>{name}</p>
                </div>
                <nav>
                    <Link to="/teacher" className={'navTeacher' + ' ' + (activeLink === 1? "active": "")} onClick={() => setActiveLink(1)}>Летучки</Link>
                    <Link to="/teacher/check" className={'navTeacher' + ' ' + (activeLink === 2? "active": "")} onClick={() => setActiveLink(2)}>Проверка</Link>
                    <Link to="/teacher/statistics" className={'navTeacher' + ' ' + (activeLink === 3? "active": "")} onClick={() => setActiveLink(3)}>Статистика</Link>
                    <Link to="/teacher/analytics" className={'navTeacher' + ' ' + (activeLink === 4? "active": "")} onClick={() => setActiveLink(4)}>Аналитика</Link>
                    <Link to="/teacher/news" className={'navTeacher' + ' ' + (activeLink === 5? "active": "")} onClick={() => setActiveLink(5)}>Объявления</Link>
                    <Outlet/>
                </nav>
                <div className={'home ' + (openNavPanel ? "": "active")}  onClick={home}>Выход</div>
                <div className='closeMenu' onClick={() => setOpenNavPanel(false)}></div>
            </div>
            <div className='page'>
                <StateTeacherContext.Provider value={{state, setState}}>
                    <Routes >
                        <Route path='/' element = {<ListBriefingT/>}/>
                        <Route path='/briefing' element = {<BriefingT/>}/>
                        <Route path='/briefing/add' element = {<NewBriefing/>}/>
                        <Route path='/briefing/insideBriefing' element = {<InsideBriefingT/>}/>
                        <Route path='/briefing/insideBriefing/student' element = {<InsideBriefingStudentT/>}/>
                        <Route path='/check' element = {<UntestedSubject/>}/>
                        <Route path='/check/untestedBriefing/*' element = {<PageUntested/>}/>
                        <Route path='/statistics' element = {<Statistics/>}/>
                        <Route path='/analytics' element = {<AnaliticsHome/>}/>
                        <Route path='/analytics/studentGroup' element = {<StudentGroup/>}/>
                        <Route path='/analytics/questions' element = {<Questions/>}/>
                        <Route path='/analytics/brifingYear' element = {<Effectiveness/>}/>
                        <Route path='/analytics/anomalies' element = {<Anomalies/>}/>
                        <Route path='/news' element = {<NewsT/>}/>
                    </Routes>
                </StateTeacherContext.Provider>
                <div className={'menu ' + (openNavPanel ? "": "active")}  onClick={() => setOpenNavPanel(true)}></div>
            </div>
            
        </article>
    )
}

export default Teacher;