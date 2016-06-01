			  var browser  = navigator.appName   //check for browser type
       
        function numberOnly(e)
				{
					if(window.event ) // IE
					{
			 
							if( (e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 8 )
                  {
										e.returnValue = false
			    				}
           }
					else if(e.which) // Netscape/Firefox
           {
								if( (e.which < 48 || e.which > 57) && e.which != 8 )
			  				  {		
                   		return false
			    				}
					 }
               
				}// numberOnly()
				
				function disableReturnKey(e)
				{
					if(window.event ) // IE
					{
			 
							if( e.keyCode == 13  )
                  {
										e.returnValue = false
			    				}
           }
					else if(e.which) // Netscape/Firefox
           {
								if( e.which == 13  )
			  				  {		
                   		return false
			    				}
					 }
               
				}// disableReturnKey()

			  function ipCheck(e)
				{
					if(window.event ) // IE
					{
			 
							if( (e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 8 && e.keyCode != 46 )
                  {
										e.returnValue = false
			    				}
           }
					else if(e.which) // Netscape/Firefox
           {
								if( (e.which < 48 || e.which > 57) && e.which != 8 && e.which != 46 )
			  				  {		
                   		return false
			    				}
					 }
					
			} // ipCheck() 

			function exclusionRange(e)
			{
					if(window.event ) // IE
						{
			 
							if( (e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 8 && e.keyCode != 32 && e.keyCode !=13 )
                  {
										e.returnValue = false
			    				}
           }
					else if(e.which) // Netscape/Firefox
           {
								if( (e.which < 48 || e.which > 57) && e.which != 8 && e.which != 32 && e.which != 13 )
			  				  {		
                   		return false
			    				}
					 }

			} //exclusionRange() 


