package service;

import dto.UserDTO;
import entity.User;

public class UserService {
    public UserDTO toUserLoginDTO(User user){
        if (user == null) return null;

        return new UserDTO(
                user.getId(),
                user.getEmail(),
                user.getPassword(),
                user.getName(),
                user.getGender(),
                user.getMobile(),
                user.getAvatar(),
                user.getAddress(),
                user.getBalance(),
                user.getRoleId()
        );
    }
}
