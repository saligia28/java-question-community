package com.example.repository;

import com.example.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * 用户数据访问层接口
 * 提供用户相关的数据库操作
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    /**
     * 根据用户名查找用户
     * @param username 用户名
     * @return 用户对象
     */
    Optional<User> findByUsername(String username);
    
    /**
     * 根据邮箱查找用户
     * @param email 邮箱
     * @return 用户对象
     */
    Optional<User> findByEmail(String email);
    
    /**
     * 根据用户名或邮箱查找用户
     * @param username 用户名
     * @param email 邮箱
     * @return 用户列表
     */
    List<User> findByUsernameOrEmail(String username, String email);
    
    /**
     * 检查用户名是否存在
     * @param username 用户名
     * @return 是否存在
     */
    boolean existsByUsername(String username);
    
    /**
     * 检查邮箱是否存在
     * @param email 邮箱
     * @return 是否存在
     */
    boolean existsByEmail(String email);
    
    /**
     * 根据用户状态查找用户
     * @param status 用户状态
     * @return 用户列表
     */
    List<User> findByStatus(User.UserStatus status);
    
    /**
     * 根据昵称模糊查询用户
     * @param nickname 昵称
     * @return 用户列表
     */
    List<User> findByNicknameContainingIgnoreCase(String nickname);
    
    /**
     * 根据用户名模糊查询用户
     * @param username 用户名
     * @return 用户列表
     */
    List<User> findByUsernameContainingIgnoreCase(String username);
    
    /**
     * 自定义查询：根据多个条件查找用户
     * @param username 用户名（可选）
     * @param email 邮箱（可选）
     * @param status 状态（可选）
     * @return 用户列表
     */
    @Query("SELECT u FROM User u WHERE " +
           "(:username IS NULL OR u.username LIKE %:username%) AND " +
           "(:email IS NULL OR u.email LIKE %:email%) AND " +
           "(:status IS NULL OR u.status = :status)")
    List<User> findUsersByCriteria(@Param("username") String username,
                                   @Param("email") String email,
                                   @Param("status") User.UserStatus status);
    
    /**
     * 统计活跃用户数量
     * @return 活跃用户数量
     */
    @Query("SELECT COUNT(u) FROM User u WHERE u.status = 'ACTIVE'")
    long countActiveUsers();
    
    /**
     * 查找最近注册的用户
     * @param limit 限制数量
     * @return 用户列表
     */
    @Query("SELECT u FROM User u ORDER BY u.createdAt DESC")
    List<User> findRecentUsers(@Param("limit") int limit);
} 