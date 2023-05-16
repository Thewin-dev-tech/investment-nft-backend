import { Module, NestModule,MiddlewareConsumer } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { LoggerMiddleware } from './middlewares/logger.middleware';
import { CustomerModule } from './customer/customer.module';
import { EncryptionModule } from './encryption/encryption.module';

@Module({
  imports: [CustomerModule, EncryptionModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule{
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(LoggerMiddleware)
      .forRoutes('*');
  }
}
