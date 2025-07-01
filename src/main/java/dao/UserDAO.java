package dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import dal.DBContext;
import entity.User;

public class UserDAO extends DBContext {
    private final String isEmailInSystem = "select [activate]  from [users] where [email] = ?";
    private final String isMobileExist = "select 1 from [users] where [mobile] = ? and [activate] = 1";
    private final String register = "insert into [users] ([email], [password], [name], [gender], [mobile], " +
            "[address], [token], [role_id]) values (?,?,?,?,?,?,?,?)";
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
            RoleDAO roleDao = new RoleDAO();
            pstm.setInt(8, roleDao.getRoleIdByName("Customer"));
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
        String sql = "select [name], [email], [gender], [mobile], [address], [avatar],[status],[role_id] from [users] where id = ?";
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
                user.setStatus(rs.getBoolean("status"));
                user.setRoleId(rs.getInt("role_id"));
                return user;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }
    public ArrayList<User> getAllUsers() {
        ArrayList<User> users = new ArrayList<>();
        String sql = "SELECT [id],[email], [name], [gender], [mobile], [address], [status],[role_id] FROM [users]";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setGender(rs.getBoolean("gender"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getBoolean("status"));
                user.setRoleId(rs.getInt("role_id"));
                users.add(user);

            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return users;
    }
    public boolean changeUserStatus(int id, boolean status) {
        String sql = "UPDATE [users] SET [status] = ? WHERE [id] = ?";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setBoolean(1, status);
            pstm.setInt(2, id);
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }
    public boolean insertUser(User user) {
        String sql = "INSERT INTO [users] ([email], [password], [name], [gender], [mobile], [address], [status], [activate],[token_create_at],[token_send_at], [role_id]) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?,null, null, ?)";
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            pstm.setString(1, user.getEmail());
            pstm.setString(2, user.getPassword());
            pstm.setString(3, user.getName());
            pstm.setObject(4, user.getGender(), Types.BOOLEAN);
            pstm.setString(5, user.getMobile());
            pstm.setString(6, user.getAddress());
            pstm.setBoolean(7, user.getStatus());
            pstm.setBoolean(8, true);
            pstm.setInt(9, user.getRoleId());
            return pstm.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET name = ?, mobile = ?, address = ?, role_id = ?, gender = ?, status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getMobile());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getRoleId());
            ps.setBoolean(5, user.getGender());
            ps.setBoolean(6, user.getStatus());
            ps.setInt(7, user.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean checkExistByEmailAndMobile(String email, String mobile) {
        String sql = "select 1 from [users] where [email] = ? or [mobile] = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, email );
            ps.setString(2, mobile);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int addAccountForRegisterSubject(User user) {
        String sql = "INSERT INTO [users] ([email], [mobile], [name], [gender], [address], [token_create_at], [token_send_at], [temp_user], [role_id]) " +
                "VALUES (?, ?, ?, ?, ?, NULL, NULL, 1, ?)";
        try (PreparedStatement pstm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstm.setString(1, user.getEmail());
            pstm.setString(2, user.getMobile());
            pstm.setString(3, user.getName());
            pstm.setObject(4, user.getGender(), Types.BIT);
            pstm.setString(5, user.getAddress());
            RoleDAO roleDAO = new RoleDAO();
            pstm.setInt(6, roleDAO.getRoleIdByName("Customer"));
            int affectedRows = pstm.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstm.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public boolean checkTempUser(String email){
        String sql = "select [temp_user] from [users] where [email] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, email);
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                return rs.getBoolean("temp_user");
            }
        }catch (SQLException e){
            System.out.println("Error: " + e.getMessage());
        }
        return false;
    }



    public ArrayList<User> getUsersByPage(Integer roleId, Integer gender, Integer status, String searchText,
                                          int page, int pageSize, String sortField, String sortOrder) {
        ArrayList<User> users = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT * FROM Users WHERE 1=1");


        if (roleId != null) {
            sql.append(" AND role_id = ?");
        }
        if (gender != null) sql.append(" AND gender = ?");
        if (status != null) sql.append(" AND status = ?");
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND (name LIKE ? OR email LIKE ? OR mobile LIKE ?)");
        }
        List<String> allowedFields = Arrays.asList("id", "name", "email", "gender", "mobile", "address", "status", "role_id");
        if (!allowedFields.contains(sortField)){
            sortField = "id";

        }
        if (!sortOrder.equalsIgnoreCase("asc") && !sortOrder.equalsIgnoreCase("desc")){
            sortOrder = "asc";
        }
        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (roleId != null) pstm.setInt(paramIndex++, roleId);
            if (gender != null) pstm.setInt(paramIndex++, gender);
            if (status != null) pstm.setInt(paramIndex++, status);
            if (searchText != null && !searchText.isEmpty()) {
                String searchPattern = "%" + searchText + "%";
                pstm.setString(paramIndex++, searchPattern);
                pstm.setString(paramIndex++, searchPattern);
                pstm.setString(paramIndex++, searchPattern);
            }
            pstm.setInt(paramIndex++, offset);
            pstm.setInt(paramIndex, pageSize);

            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setGender(rs.getBoolean("gender"));
                user.setStatus(rs.getBoolean("status"));
                user.setRoleId(rs.getInt("role_id"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
        return users;
    }


    public int getTotalUsers(Integer roleId, Integer gender, Integer status, String searchText) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Users WHERE 1=1");

        if (roleId != null) {
            sql.append(" AND role_id = ?");
        }
        if (gender != null) {
            sql.append(" AND gender = ?");
        }
        if (status != null) {
            sql.append(" AND status = ?");
        }
        if (searchText != null && !searchText.isEmpty()) {
            sql.append(" AND (name LIKE ? OR email LIKE ? OR mobile LIKE ?)");
        }

        try (PreparedStatement pstm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (roleId != null) {
                pstm.setInt(paramIndex++, roleId);
            }
            if (gender != null) {
                pstm.setInt(paramIndex++, gender);
            }
            if (status != null) {
                pstm.setInt(paramIndex++, status);
            }
            if (searchText != null && !searchText.isEmpty()) {
                String searchPattern = "%" + searchText + "%";
                pstm.setString(paramIndex++, searchPattern);
                pstm.setString(paramIndex++, searchPattern);
                pstm.setString(paramIndex++, searchPattern);
            }

            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }

        return 0;
    }

    public ArrayList<User> getAllExpert(){
        ArrayList<User> users = new ArrayList<>();
        String sql = """
        SELECT [id],[email], [name], [gender], [mobile], [address], [status] FROM [users]
        WHERE [role_id] = 2
        """;
        try {
            PreparedStatement pstm = connection.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setGender(rs.getBoolean("gender"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getBoolean("status"));
                users.add(user);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return users;
    }

    public User getForSale(Integer id) {
        String sql = "select [email], [name], [gender], [mobile], [temp_user] from [users] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(id);
                user.setEmail(rs.getString("email"));
                user.setName(rs.getString("name"));
                Boolean gender = rs.getBoolean("gender");
                if (rs.wasNull()) {
                    gender = null;
                }
                user.setGender(gender);
                user.setMobile(rs.getString("mobile"));
                user.setTempUser(rs.getBoolean("temp_user"));
                return user;
            }
        }catch (SQLException e){
            System.err.println("Error: " + e.getMessage());
        }
        return null;
    }

    public void activateRegistration(Integer id, String password) {
        String sql = "update [users] set [password] = ?, [temp_user] = 0, [activate] = 1 where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setString(1, password);
            pstm.setInt(2, id);
            pstm.executeUpdate();
        }catch (SQLException e){
            System.err.println("Error: " + e.getMessage());
        }
    }

    public void deleteTempUser(Integer id) {
        String sql = "delete from [users] where [id] = ?";
        try(PreparedStatement pstm = connection.prepareStatement(sql)){
            pstm.setInt(1, id);
            pstm.executeUpdate();
        }catch (SQLException e){
            System.err.println("Error: " + e.getMessage());
        }
    }
}