import mongoose from "mongoose";

const UserSchema = new mongoose.Schema(
	{
		name: {
			type: String,
			required: true,
		},
		email: {
			type: String,
			required: true,
			unique: true,
		},
		password: {
			type: String,
			minlength: 8,
			required: true,
		},
		profilePic: {
			type: String,
			default: "",
		},
		phoneNo:{
            type: String,
            defualt:"",
            required:true
        },
        aadharNo:{
            type:String ,
            default:"",
            required:true
        },
	},
	{ timestamps: true }
);

const User = mongoose.model("User", UserSchema);
export default User;
