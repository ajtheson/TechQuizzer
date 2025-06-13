package service;

import dao.RoleDAO;
import dto.UserDTO;
import entity.User;

public class UserService {
    public UserDTO toUserLoginDTO(User user){
        if (user == null) return null;

        RoleDAO roleDAO = new RoleDAO();
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
                user.getRoleId(),
                roleDAO.getRoleNameById(user.getRoleId())
        );
    }
}
