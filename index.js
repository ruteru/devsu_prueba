import sequelize from './shared/database/database.js'
import { usersRouter } from "./users/router.js"
import express from 'express'

const app = express()

(async () => {
    try {
      await sequelize.sync({ force: true });
      console.log('db is ready');
    } catch (error) {
      console.error('Error syncing database:', error);
    }
  })();
  
app.use(express.json())
app.use('/api/users', usersRouter)

const server = app.listen(8000, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
});

export { app, server }