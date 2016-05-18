/* Global javascript functions */

/* ----- jQuery is required ----- */
if (typeof jQuery === 'undefined') { throw new Error('jQuery is required'); }

/* ----- check validate functions --- */
/* check email address end with swin.edu.au */
function isValidEmail(email){
  if(email==''){
    return false;
  }
  // ....
  return true;
}



/* ----- ajax request response ----- */

// jquery ajax sending a serialized form
// params: url, form, complete, method, log
// call complete function, passing response object {error,data}
function ajaxForm(params){
  var response = {'error':'','data':null};

  // check arguments
  if(!params){
    throw new Error('Function requires arguments');
    return false;
  }
  if(!params.url){
    throw new Error('Url argument is required');
    return false;
  }
  if(!params.form){
    throw new Error('Form argument is required');
    return false;
  }
  try{
    var formData = jQuery(params.form).serialize();
  }catch(e){
    throw new Error('Unable serialize form');
    return false;
  }
  if(!params.complete){
    throw new Error('Complete function is required');
    return false;
  }else if(typeof params.complete !== 'function'){
    throw new Error('Complete must be a function');
    return false;
  }
  if(!params.method){
    params.method = 'GET';
  }
  if (typeof jQuery === 'undefined') {
    response.error = 'jQuery is required';
    params.complete(response);
    return false;
  }
  // log or not
  if(params.log){console.log('Request Data: '+formData);}
  // ajax
  jQuery.ajax({
    'method':params.method,
    'url':params.url,
    'data':formData,
    'success':function(data,status,xhr){
      if(params.log){console.log('Response Data: '+data);}
      try{
        response = JSON.parse(data);
        params.complete(response);
      }catch(e){
        response.error = 'Unexpected error';
        params.complete(response);
      }
    },
    'error':function(xhr,status,error){
      response.error = error;
      params.complete(response);
    }
  });
}// end ajaxForm


// jquery ajax get data
// params: url, data, complete, method, log
// call complete function, passing response object {error,data}
function ajaxData(params){
  var response = {'error':'','data':null};

  // check arguments
  if(!params){
    throw new Error('Function requires arguments');
    return false;
  }
  if(!params.url){
    throw new Error('Url argument is required');
    return false;
  }
  if(!params.data){
    throw new Error('Data argument is required');
    return false;
  }
  if(!params.complete){
    throw new Error('Complete function is required');
    return false;
  }else if(typeof params.complete !== 'function'){
    throw new Error('Complete must be a function');
    return false;
  }
  if(!params.method){
    params.method = 'GET';
  }
  if (typeof jQuery === 'undefined') {
    response.error = 'jQuery is required';
    params.complete(response);
    return false;
  }
  // ajax
  jQuery.ajax({
    'method':params.method,
    'url':params.url,
    'data':params.data,
    'success':function(data,status,xhr){
      if(params.log){console.log('Response Data: '+data);}
      try{
        response = JSON.parse(data);
        params.complete(response);
      }catch(e){
        response.error = 'Unexpected error';
        params.complete(response);
      }
    },
    'error':function(xhr,status,error){
      response.error = error;
      params.complete(response);
    }
  });
}
