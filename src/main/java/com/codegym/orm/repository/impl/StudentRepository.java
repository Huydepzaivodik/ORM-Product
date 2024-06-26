package com.codegym.orm.repository.impl;

import com.codegym.orm.model.Student;
import com.codegym.orm.repository.IStudentRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.List;

@Transactional
@Repository
public class StudentRepository implements IStudentRepository {

    //Dùng để ánh xạ đến Database khi sử dụng entityManager
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Student> findAll() {
        TypedQuery<Student> query = entityManager.createQuery("select s from Student s", Student.class);
        return query.getResultList();
    }

    @Override
    public Student findById(Long id) {
        TypedQuery<Student> query = entityManager.createQuery("select s from Student s where s.id=:id", Student.class);
        query.setParameter("id", id);
        return query.getSingleResult();
    }

    @Override
    public void save(Student student) {
        if (student.getId() != null) {
            entityManager.merge(student);
        } else {
            entityManager.persist(student);
        }

    }

    @Override
    public void remove(Long id) {
        Student student = findById(id);
        if (student != null) {
            entityManager.remove(student);
        }
    }

    @Override
    public List<Student> findByName(String name) {
        TypedQuery<Student> query = entityManager.createQuery("select s from Student s where s.name LIKE :namePattern", Student.class);
        query.setParameter("namePattern", "%" +name.trim() + "%");
        return query.getResultList();
    }
}
