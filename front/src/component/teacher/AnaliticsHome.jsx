import '../../css/analitic.css'
import { Link } from 'react-router-dom';

function AnaliticsHome(){
    return(
        <div className='analitic'>
            <div className='line'>
                <h2 className='title'>Аналитика</h2>
                <div></div>
            </div>
            <div className='listAnaliticOption'>
                <ul>
                    <li> <Link to="/teacher/analytics/studentGroup">Сравнение результатов летучек разных групп студентов</Link></li>
                    <li> <Link to="/teacher/analytics/questions">Анализ распределения оценок по отдельным вопросам летучек.</Link></li>
                    <li> <Link to="/teacher/analytics/brifingYear">Оценка эффективности учебных программ на основе результатов летучек за несколько лет</Link></li>
                    <li> <Link to="/teacher/analytics/anomalies">Анализ распределения оценок по летучкам / выявление аномалий</Link></li>
                </ul>
            </div>
        </div>
    )
}

export default AnaliticsHome;