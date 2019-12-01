<?php
    require_once('controllers/base_controller.php');
    require_once('models/movie.php');
    require_once('models/kind.php');

    class MoviesController extends BaseController {
        function __construct() {
            $this->folder = "movies";
        }

        public function index() {
            
            $kinds = Kind::all();
            if (isset($_GET['kind_id'])) {
                $movies = Movie::searchByKind($_GET['kind_id']);
            }
            else {
                $movies = Movie::all();
            }
            $data = array('movies' => $movies, 'kinds' => $kinds);
            $this->render('index', $data);
        }

        public function info()
        {
          $movie = Movie::searchById($_GET['movie_id']);
          $data = array('movie' => $movie);
          
          $this->render('info', $data);
        }

        public function add() {
            $kinds = Kind::all();
            $data = array('kinds' => $kinds);
            $this->render('add', $data);
        }

        public function create() {
            $kindArr = implode("," , $_POST['movie_kind']);
            print_r($kindArr);
            //echo $kindArr;
            if(isset($_FILES['movie_picture']) && getimagesize($_FILES['movie_picture']['tmp_name']) != false){
                $picture = file_get_contents($_FILES['movie_picture']['tmp_name']);
                $picture = addslashes($picture);
                
                //print_r("success");
            }
            $movie = Movie::create($_POST['movie_name'], $_POST['movie_length'], $kindArr, $_POST['movie_trailer'], ''.$picture);
            // header("Location: index.php?controller=movies");
            // header('Location: index.php');
        }

        public function searchByName(){
            echo $_POST['movie_name'];
            $movies = Movie::searchByName($_POST['movie_name']);
            $data = array('movies' => $movies);
            if($data){
                $this->render('index', $data);
                //print_r($data);
            }else{
                echo "ERROR";
            }
        }
        
        public function searchByID(){
            echo $_POST['movie_name'];
            $movies = Movie::searchByID($_POST['movie_id']);
            $data = array('movies' => $movies);
            if($data){
                $this->render('index', $data);
                //print_r($data);
            }else{
                echo "ERROR";
            }
        }

        public function searchByKind(){
            //echo $_POST['movie_kind'];
           // $movies = Movie::searchByName($_POST['movie_kind']);
            $movies = Movie::searchByKind($_GET['movie_kind']);
            $data = array('movies' => $movies);
            if($data){
                $this->render('index', $data);
                //print_r($data);
            }else{
                echo "ERROR";
            }
        }
        
        public function renderUpdateForm()
        {
          $movie = Movie::searchById($_GET['movie_id']);
          $kinds =Kind::all();
          $data = array('movie' => $movie, 'kinds'=>$kinds);
          
          $this->render('update', $data);
        }

        public function update() {
            $kindArr = implode("," , $_POST['movie_kind']);
            //echo $kindArr;
            if(isset($_FILES['movie_picture'])){
                $picture = file_get_contents($_FILES['movie_picture']['tmp_name']);
                $picture = addslashes($picture);
            }
            $movie = Movie::update($_POST['movie_name'], $_POST['movie_length'], $kindArr, $_POST['movie_trailer'], $picture);
            //header("Location: index.php?controller=movies");
            echo "<a href='index.php'>Continue</a>";
        }

    }
?>