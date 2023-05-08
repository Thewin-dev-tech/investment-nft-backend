import { Module, NestModule,MiddlewareConsumer } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { CustomerController } from './controllers/customer.controller';
import { CustomerService } from './services/customer.service';

import { LoggerMiddleware } from './middlewares/logger.middleware';

@Module({
  imports: [],
  controllers: [AppController,CustomerController],
  providers: [AppService,CustomerService],
})
export class AppModule implements NestModule{
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(LoggerMiddleware)
      .forRoutes('*');
  }
}
