<html>
    <body>
        <div>
            <form action="index.php?controller=schedules&action=create" method="POST">
            <div class="form-group">
                <label for="schedule_id">Email address</label>
                <input type="text" class="form-control" id="schedule_id" placeholder="Schedule ID" name="schedule_id">
            </div>
            <div class="form-group">
                <label for="schedule_time_start">Time Start</label>
                <input type="datetime-local" class="form-control" id="schedule_time_start" value="2019-01-01 05:00:00"name="schedule_time_start">
                
            </div>
            <div class="form-group">
                <label for="cinema_id">Cinema ID</label>
                <select name="cinema_id" class="form-control" aria-labelledby="cinema_id">
                    <?php
                        foreach($cinemas as $cinema){
                        }
                    ?>
                    <option class="dropdown-item" value=<?php echo $cinema->cinema_id ?>> <?php echo $cinema->cinema_id ?></option>
                </select>
            </div>
            <div class="form-group">
                <label for="movie_id">Movie ID</label>
                <select name="movie_id" class="form-control" aria-labelledby="movie_id">
                    <?php
                        foreach($movies as $movie){
                        }
                    ?>
                    <option class="dropdown-item" value=<?php echo $movie->movie_id ?> ><?php echo $movie->movie_id ?></option>
                </select>
            </div>

            <button type="submit" class="btn btn-secondary">Submit</button>
            </form>
        </div>
    </body>
</html>