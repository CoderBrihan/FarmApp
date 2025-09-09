import bcrypt from "bcryptjs";
import fs from "fs";
import User from "../models/user.model.js";
import cloudinary from "../lib/cloudinary.js";

export const signUp = async (req, res) => {
	try {
        if (!req.body){
            res.status(400).json({ message: "All fields should be filled" });
			return;
        }
		const name = req.body.name.trim();
		const email = req.body.email.trim();
		const password = req.body.password.trim();
		const phoneNo = req.body.phoneNo.trim();
		const aadharNo = req.body.aadharNo.trim();

		if (!name || !email || !password ||!phoneNo || !aadharNo) {
			res.status(400).json({ message: "All fields should be filled" });
			return;
		}
		if (name.length < 4) {
			res.status(400).json({
				message: "Name must be greater than 4 characters ",
			});
			return;
		}
		if (password.length < 8) {
			res.status(400).json({
				message: "Password must be greater than 8",
			});
			return;
		}
		if (phoneNo.length != 10) {
			res.status(400).json({
				message: "Phone No must be 10 digits",
			});
			return;
		}
		if (aadharNo.length != 12) {
			res.status(400).json({
				message: "Aadhar No must be 12 digits",
			});
			return;
		}

		const userEmailPresent = await User.findOne({ email });
		const userPhonePresent = await User.findOne({ phoneNo });
		const userAadharPresent = await User.findOne({ aadharNo });
		if (userEmailPresent || userPhonePresent || userAadharPresent) {
			res.status(400).json({
				message:
					"User with one or more matching details already exists",
			});
			return;
		}

		const salt = await bcrypt.genSalt(10);
		const hashedPassword = await bcrypt.hash(password, salt);
		const newUser = new User({
			name,
			email,
			phoneNo,
			aadharNo,
			password: hashedPassword,
		});
		
		await newUser.save();
		return res.status(201).json(newUser);
	} catch (error) {
		console.log("Error in sign-up ", error);
		res.status(500).json({ message: "Internal Server Error" });
	}
};

export const logIn = async (req, res) => {
	try {
		const input = req.body.input.trim();
		const password = req.body.password.trim();

		const userEmailPresent = await User.findOne({ email: input });
		const userPhonePresent = await User.findOne({ phoneNo: input });
		const userAadharPresent = await User.findOne({ aadharNo: input });
		if (!userEmailPresent && !userPhonePresent && !userAadharPresent) {
			res.status(400).json({ message: "Invalid credinials" });
			return;
		}
		let user;
		if (userAadharPresent) user = userAadharPresent;
		else if (userEmailPresent) user = userEmailPresent;
		else if (userAadharPresent) user = userAadharPresent;

		const hashedPassword = await bcrypt.compare(password, user.password);
		if (!hashedPassword) {
			res.status(400).json({ message: "Invalid credinials" });
			return;
		}
		
		return res.status(201).json(user);
	} catch (error) {
		console.log("Error in login ", error);
		res.status(500).json({ message: "Internal Server Error" });
	}
};

export const changePic = async (req, res) => {
	try {
        let input = req.body.input;
		const userEmailPresent = await User.findOne({ email: input });
		const userPhonePresent = await User.findOne({ phoneNo: input });
		const userAadharPresent = await User.findOne({ aadharNo: input });
		if (!userEmailPresent && !userPhonePresent && !userAadharPresent) {
			res.status(400).json({ message: "Invalid credinials" });
			return;
		}
		let user;
		if (userAadharPresent) user = userAadharPresent;
		else if (userEmailPresent) user = userEmailPresent;
		else if (userAadharPresent) user = userAadharPresent;
		const filePath = req.file.path;

		if (user.profilePic) {
			const publicID = getPublicID("farm-app/avatars/", user.profilePic);
			await cloudinary.uploader.destroy(publicID);
		}
		const uploadRes = await cloudinary.uploader.upload(filePath, {
			folder: "farm-app/avatars",
			transformation: [{ quality: "auto" }],
		});

		user.profilePic = uploadRes.secure_url;
		await user.save();
		fs.unlinkSync(filePath);
		res.status(200).json(user);
	} catch (error) {
		console.log("Error in changing profile pic", error);
		res.status(400).json({ message: "Internal server error" });
	}
};
