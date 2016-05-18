<?php
/* Global functions */

/* check, validate functions  */

function isValidEmail($email){
  if(empty($email)){
    return false;
  }
  // ....
  return true;
}


/* password hash */
function passwordHash($str){
  return md5(md5($str));
}

?>
