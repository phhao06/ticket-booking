<?php
    class Schedule {
        public $schedule_id;
        public $schedule_time_start;
        public $cinema_id;
        public $movie_id;
        public $movie_name;


        function __construct($id, $time_start, $cinema_id, $movie_id, $movie_name){
            $this->schedule_id = $id;
            $this->schedule_time_start = $time_start;
            $this->cinema_id = $cinema_id;
            $this->movie_id = $movie_id;
            $this->movie_name = $movie_name;
        }

        //get all schedule
        public static function all() {
            $schedules = [];
            $db = DB::getInstance();
            $req = $db->query('select * from schedule inner join movie on schedule.movie_movie_id = movie.movie_id 
            inner join cinema on cinema.cinema_id = schedule.cinema_cinema_id;');
            foreach($req->fetchAll() as $item){
                $schedules[] = new Schedule($item['schedule_id'], $item['schedule_time_start'],
                             $item['cinema_cinema_id'], $item['movie_movie_id'],$item['movie_name']);
            }
            return $schedules;
        }

        // find schedule of movie_id
        public function find($movie_id) {
            $schedulesID = [];
            $db = DB::getInstance();
            $req = $db->prepare('SELECT * FROM schedule inner join movie 
                                            on schedule.movie_movie_id = movie.movie_id 
                                            WHERE movie_movie_id = :id');
            $req->execute(array('id' => $movie_id));

            foreach($req->fetchAll() as $item){
                $schedulesID[] = new Schedule($item['schedule_id'], $item['schedule_time_start'],
                            $item['cinema_cinema_id'], $item['movie_id'],$item['movie_name']);
            }
            return $schedulesID;
        }

        // create new schedule
        public function create($id, $time, $ci_id, $movie_id){
            $db = DB::getInstance();
            $req = $db->prepare("INSERT INTO schedule (schedule_id, schedule_time_start, cinema_cinema_id, movie_movie_id) 
            VALUES (':id', ':time', ':ci_id', 'movie_id');");
            $req->execute(array('id'=>$id, 'time'=>$time, 'ci_id'=>$ci_id, 'movie_id'=>$movie_id));
        }
       

        // Test function 
        public function search($movie_id, $date) {
            $date_0h = $date." "."00:00:00";
            $date_24h = $date." "."23:59:59";
            $schedulesID = [];
            $db = DB::getInstance();
            $req = $db->prepare('SELECT * FROM schedule 
                                            WHERE movie_movie_id = :movie_id
                                            AND columname BETWEEN :date_0h AND :date_24h' );
                                            
            $req->execute(array('movie_id' => $movie_id, "date_0h" => $date_0h, "date_24h" => $date_24h));

            foreach($req->fetchAll() as $item){
                $schedulesID[] = new Schedule($item['schedule_id'], $item['schedule_time_start'],
                            $item['cinema_cinema_id'], $item['movie_id'],$item['movie_name']);
            }
            return $schedulesID;
        }
    }
?>