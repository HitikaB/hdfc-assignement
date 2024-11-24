const mysql=require("mysql");

const con= mysql.createPool({
        connectionLimit:10,
        host :process.env.DB_HOST,
        user: process.env.DB_USER,
        password:process.env.DB_PASS,
        database:process.env.DB_NAME
    
    });

    exports.view =(req,res)=>{
        con.getConnection((err,connection)=>{
            if(err) throw err
            connection.query("select *  from users",(err, rows)=>{ //connection.query() and connection.release() are methods commonly used for interacting with the database and managing database connections.
                connection.release();  //connection.query() method is used to execute SQL queries against your database
                //connection.release() is used to release a connection back to the pool after you’re done with it. 
                if(!err){
                    res.render("home",{rows});
                }else{
                    console.log("Error in listing Data" +err);
                }
            })
           
        });

       
    };

    exports.adduser=(req,res)=>{
        res.render("adduser");
    }

    exports.save=(req,res)=>{
        console.log(req.body);
        con.getConnection((err,connection)=>{
            if(err) throw err
            const {name,age,city} =req.body;
            connection.query("insert into users (NAME,AGE,CITY) values(?,?,?)",[name,age,city],(err,rows)=>
            {
                connection.release();  
                
                if(!err){
                    res.render("adduser",{msg:"User Details Added successfully"});
                }else{
                    console.log("Error in listing Data" +err);
                }
            });
           
        });

    }

    exports.edituser=(req,res)=>{
       con.getConnection((err,connection)=>{
        if(err) throw err
        //get id from url
        let id=req.params.id;

        connection.query("select * from users where id=?",[id],(err,rows)=>{
            connection.release();
            if(!err){
                res.render("edituser",{rows});
            }else{
                console.log("Error in Listing data"+err);
            }
        });
       })
    }

    exports.edit=(req,res)=>{
        //console.log(req.body);
        con.getConnection((err,connection)=>{
            if(err) throw err
            const {name,age,city} =req.body;
            let id=req.params.id;
            connection.query("update users set NAME=?,AGE=?,CITY=? Where ID=?",[name,age,city,id],(err,rows)=>
            {
                connection.release();  
                
                if(!err){

                    con.getConnection((err,connection)=>{
                        if(err)throw err
                        let id=req.params.id;
                        connection.query("select * from users where id=?",[id],(err,rows)=>{
                            connection.release();
                            if(!err){
                                res.render("edituser",{rows,msg:"User Details updated successfully"});
                            }
                            else{
                                console.log("Error in listing Data" +err);
                            }
                        })
                    })
                    
                }
            });
           
        });



    }

    exports.delete=(req,res)=>{
        con.getConnection((err,connection)=>{
            if(err) throw err

            //get id from url
            let id = req.params.id;
            connection.query("delete from users where id=?",[id],(err,rows)=>{
                connection.release();
                if(!err){
                    res.redirect("/");
                }else{
                    console.log(err);
                }
            })
        })
    }
