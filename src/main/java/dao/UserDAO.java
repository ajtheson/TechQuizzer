package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;

import dal.DBContext;
import entity.User;

public class UserDAO extends DBContext {
    private final String isEmailInSystem = "select [activate]  from [users] where [email] = ?";
    private final String isMobileExist = "select 1 from [users] where [mobile] = ? and [activate] = 1";
    private final String register = "insert into [users] ([email], [password], [name], [gender], [mobile], " +
            "[address], [token], [role_id]) values (?,?,?,?,?,?,?,3)";
    private final String getTokenInformation = "select [token], [token_create_at], [token_send_at] from [users] where [email] = ?";
    private final String updateToken = "update [users] set [token] = ?, [token_create_at] = ?, [token_send_at] = ? where [email] = ?";
    private final String getMobile = "select [mobile] from [users] where [email] = ?";
    private final String getVerifyInformation = "select [email], [token_create_at] from [users] where [token] = ?";
    private final String activateAccount = "update [users] set [activate] = 1, [token] = null, [token_create_at] = null, [token_send_at] = null where [email] = ?";
    private final String resetPassword = "update [users] set [password] = ? where [email] = ?";

    public User isEmailInSystem(String email) {
        try {
            PreparedStatement pstm = connection.prepareStatement(isEmailInSystem);
            pstm.setString(1, email);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                boolean active = rs.getBoolean("activate");
                User user = new User();
                user.setActivate(active);
                return user;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean isMobileExist(String mobile) {
        try {
            PreparedStatement pstm = connection.prepareStatement(isMobileExist);
            pstm.setString(1, mobile);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean register(User user) {
        try {
            PreparedStatement pstm = connection.prepareStatement(register);
            pstm.setString(1, user.getEmail());
            pstm.setString(2, user.getPassword());
            pstm.setString(3, user.getName());
            pstm.setObject(4, user.getGender(), Types.BIT);
            pstm.setString(5, user.getMobile());
            pstm.setString(6, user.getAddress());
            pstm.setString(7, user.getToken());
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public User getTokenInformation(String email) {
        try {
            PreparedStatement pstm = connection.prepareStatement(getTokenInformation);
            pstm.setString(1, email);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setToken(rs.getString("token"));
                Timestamp tokenCreateAt = rs.getTimestamp("token_create_at");
                if (tokenCreateAt != null) {
                    user.setTokenCreateAt(tokenCreateAt.toLocalDateTime());
                } else {
                    user.setTokenCreateAt(null);
                }
                Timestamp tokenSendAt = rs.getTimestamp("token_send_at");
                if (tokenSendAt != null) {
                    user.setTokenSendAt(tokenSendAt.toLocalDateTime());
                } else {
                    user.setTokenSendAt(null);
                }

                return user;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean updateToken(String email, String token, LocalDateTime tokenCreateAt, LocalDateTime tokenSendAt) {
        try {
            PreparedStatement pstm = connection.prepareStatement(updateToken);
            pstm.setString(1, token);
            pstm.setObject(2, tokenCreateAt);
            pstm.setObject(3, tokenSendAt);
            pstm.setString(4, email);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public String getMobile(String email) {
        try {
            PreparedStatement pstm = connection.prepareStatement(getMobile);
            pstm.setString(1, email);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getString("mobile");
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public User getVerifyInformation(String token) {
        try {
            PreparedStatement pstm = connection.prepareStatement(getVerifyInformation);
            pstm.setString(1, token);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setEmail(rs.getString("email"));
                Timestamp tokenCreateAt = rs.getTimestamp("token_create_at");
                if (tokenCreateAt != null) {
                    user.setTokenCreateAt(tokenCreateAt.toLocalDateTime());
                } else {
                    user.setTokenCreateAt(null);
                }
                return user;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean activateAccount(String email) {
        try {
            PreparedStatement pstm = connection.prepareStatement(activateAccount);
            pstm.setString(1, email);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean resetPassword(String email, String password) {
        try {
            PreparedStatement pstm = connection.prepareStatement(resetPassword);
            pstm.setString(1, password);
            pstm.setString(2, email);
            pstm.execute();
            return true;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public User getUserByEmail(String email) {
        try {
            String sql = "SELECT * FROM [users] WHERE [email] = ? AND [status] = 1 AND [activate] = 1";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                Boolean gender = rs.getBoolean("gender");
                if (rs.wasNull()) {
                    gender = null;
                }
                user.setGender(gender);
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("avatar"));
                user.setBalance(rs.getDouble("balance"));
                user.setRoleId(rs.getInt("role_id"));
                user.setWrongPasswordAttempts(rs.getInt("wrong_password_attempts"));
                Timestamp passwordChangeLockedUntil = rs.getTimestamp("password_change_locked_until");
                if (passwordChangeLockedUntil != null) {
                    user.setPasswordChangeLockedUntil(passwordChangeLockedUntil.toLocalDateTime());
                } else {
                    user.setPasswordChangeLockedUntil(null);
                }
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    public boolean updateWrongPasswordAttempts(String email, int attempts) {
        String sql = "UPDATE [users] SET [wrong_password_attempts] = ? WHERE email = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, attempts);
            pstm.setString(2, email);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean lockPasswordChange(String email, LocalDateTime lockedUntil) {
        String sql = "UPDATE [users] SET [password_change_locked_until] = ?, wrong_password_attempts = 0 WHERE email = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            if (lockedUntil != null) {
                pstm.setTimestamp(1, Timestamp.valueOf(lockedUntil));
            } else {
                pstm.setNull(1, Types.TIMESTAMP);
            }
            pstm.setString(2, email);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }

    public boolean updateUserInfo(User user) throws SQLException {
        String sql = "UPDATE [users] SET [name] = ?, [email] = ?, [gender] = ?, [mobile] = ?, [address] = ?, [avatar] = ? WHERE id = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, user.getName());
            pstm.setString(2, user.getEmail());
            pstm.setObject(3, user.getGender(), Types.BOOLEAN);
            pstm.setString(4, user.getMobile());
            pstm.setString(5, user.getAddress());
            pstm.setString(6, user.getAvatar());
            pstm.setInt(7, user.getId());

            int affectedRows = pstm.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            connection.close();
        }
        return false;
    }

    public User getUserById(int id) {
        String sql = "select [name], [email], [gender], [mobile], [address], [avatar] from [users] where id = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                Boolean gender = rs.getBoolean("gender");
                if (rs.wasNull()) {
                    gender = null;
                }
                String mobile = rs.getString("mobile");
                String address = rs.getString("address");
                String avatar = rs.getString("avatar");
                User user = new User();
                user.setId(id);
                user.setName(name);
                user.setEmail(email);
                user.setGender(gender);
                user.setMobile(mobile);
                user.setAddress(address);
                user.setAvatar(avatar);
                return user;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

}