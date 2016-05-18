<?php
/*

*/
class dbhandler{
	private $connection, $host, $dbName, $user, $pass;
	public $error;
	public $sql;
	public $lastInsertId;

	public function __construct(){
		if(func_num_args()==0){
			// set default options
			$this->dbName = 'roombooking_db';
			$this->host = 'localhost';
			$this->user = 'root';
			$this->pass = 'root';
			$this->error = '';
			$this->connect();
		}elseif(func_num_args()==4){ // host,user,password,batabase
			$this->host = func_get_arg(0);
			$this->user = func_get_arg(1);
			$this->pass = func_get_arg(2);
			$this->dbName = func_get_arg(3);
			$this->error = '';
			$this->connect();
		}else{
			$this->error = 'Invalid arguments';
		}
	}
	public function aaaa($dbName,$host,$user,$pwd){
		$this->error = "";
		$this->dbName = $dbName;
		$this->host = $host;
		$this->user = $user;
		$this->pass = $pwd;
		$this->connect();
	} // end construct

	public function __destruct(){
		$this->connection = null;
	} // end destruct

	private function connect(){
		try{
			$this->connection = new PDO("mysql:host=".$this->host.";dbname=".$this->dbName,$this->user,$this->pass);
			// set error mode
			$this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);
			return true;
		}catch(PDOException $e){
			$this->error = $e->getMessage();
			$this->connection = null;
			return false;
		}
	} // end connect


	/*
		select query
		param Sql statement
		return array of data
	*/
	public function selectQuery($sql){
		$this->error = '';
		$data = array();
		$this->sql = $sql;
		// check connection
		if($this->connection==null || $this->connection==false){
			$this->error = 'connection failed';
			return false;
		}
		// query object
		$query = $this->connection->query($this->sql);
		if($query==false){
			// error
			$errInfo = $this->connection->errorInfo();
			$this->error = $errInfo[2];
		}else{
			while($record = $query->fetch(PDO::FETCH_ASSOC)){
				array_push($data,$record);
			}
		}
		return $data;
	} // end select query


	/*
		insert to database
		param sql statement
	*/
	public function insertQuery($sql){
		$this->error = '';
		$this->sql = $sql;
		// check connection
		if($this->connection==null || $this->connection==false){
			$this->error = 'connection failed';
			return false;
		}
		$query = $this->connection->prepare($this->sql);
		$query->execute();
		$errInfo = $query->errorInfo();
		$this->error = $errInfo[2];
		if($this->error==''){
			$this->lastInsertId = $this->connection->lastInsertId();
			return $this->lastInsertId;
		}
		return false;
	}


	/*
		update table
		param sql statement
	*/
	public function updateQuery($sql){
		$this->error = '';
		$this->sql = $sql;
		// check connection
		if($this->connection==null || $this->connection==false){
			$this->error = 'connection failed';
			return false;
		}
		$query = $this->connection->prepare($this->sql);
		$query->execute();
		$errInfo = $query->errorInfo();
		$this->error = $errInfo[2];
		if($this->error==''){
			return $query->rowCount();
		}
		return false;
	}


	/*
		delete table from database
		param sql statement
	*/
	public function deleteQuery($sql){
		$this->error = '';
		$this->sql = $sql;
		// check connection
		if($this->connection==null || $this->connection==false){
			$this->error = 'connection failed';
			return false;
		}
		$query = $this->connection->prepare($this->sql);
		$query->execute();
		$errInfo = $query->errorInfo();
		$this->error = $errInfo[2];
		if($this->error==''){
			return $query->rowCount();
		}
		return false;
	}

	// Additional function

	// adding quote to column name
	public function quote($str){
		return $this->connection->quote($str);
	}


	/*
		clean sanitize input
	*/
	public function clean($str){
		$str = trim($str);
		$str = str_replace(array("'",'"'),'',$str);
		if(!get_magic_quotes_gpc()){
			$str = addslashes($str);
		}

		if(function_exists('filter_var')){
			$str = filter_var($str,FILTER_SANITIZE_STRING);
		}
		return $str;
	}

	// clean text
	public function cleanText($str){
		$str = trim($str);
		if(!get_magic_quotes_gpc()){
			$str = addslashes($str);
		}
		if(function_exits('filter_var')){
			$str = filter_var($str,FILTER_SANITIZE_STRING);
		}
		return $str;
	}


} // end DbHandler
?>
