<?php
    class Movie {
        public $movie_id;
        public $movie_name;
        public $movie_length;
        public $movie_trailer;
        public $movie_picture;

        function __construct($id, $name, $length, $trailer, $picture){
            $this->movie_id = $id;
            $this->movie_name= $name;
            $this->movie_length = $length;
            $this->movie_trailer = $trailer;
            $this->movie_picture= $picture;
        }

        //get all movies
        static function all()
        {
            $movies = [];
            $db = DB::getInstance();
            $req = $db->query('SELECT * FROM movie');
            //print_r($req->fetchAll());
            foreach ($req->fetchAll() as $item){
                $movies[] = new Movie($item['movie_id'], $item['movie_name'],
                $item['movie_length'], $item['movie_trailer'],$item['movie_picture']);
            }
            return $movies;
        }


        // find info of movie
        static function find($id)
        {
            $db = DB::getInstance();
            $req = $db->prepare('SELECT * FROM movie WHERE movie_id = :id');
            $req->execute(array('id' => $id));

            $item = $req->fetch();
            if (isset($item['movie_id'])) {
                return new Movie($item['movie_id'], $item['movie_name'],
                    $item['movie_length'], $item['movie_kind'], $item['movie_trailer'],$item['movie_picture']);
            }
            return null;
            //echo "loi r";
        }

        //create new movie
        public function create($id, $name, $length, $trailer, $picture){
            $db = DB::getInstance();
            $req = $db->prepare("INSERT INTO movie (movie_id, movie_name, movie_length, movie_trailer, movie_picture) 
                     VALUES (':id', ':name', ':length', ':trailer', ':picture')");
            return $req;
        }

        //search movie by name
        public function search($m_name) {
            $result=[];
            $db = DB::getInstance();
            $req = $db->prepare("SELECT * FROM movie WHERE movie_name LIKE %:m_name%");
            $req->execute(array('m_name' => $m_name));
            foreach ($req->fetchAll() as $item){
                $result[] = new Movie($item['movie_id'], $item['movie_name'],
                $item['movie_length'], $item['movie_kind'], $item['movie_trailer'],$item['movie_picture']);
            }
            return $result;
        }
        public function update($movie_name, $movie_length, $movie_trailer, $movie_picture) {
            $db = DB::getInstance();
            $req = $db->prepare("UPDATE movie 
                                SET movie_name = :movie_name, movie_length=:movie_length,
                                movie_trailer = :movie_trailer, movie_picture = :movie_picture
                                WHERE movie_id = 1");
            $req->execute(array("movie_name" => $movie_name, "movie_length" =>$movie_length, 
                                "movie_trailer"=>$movie_trailer, "movie_picture" =>$movie_picture));
            
        }
       
        
    }
?>