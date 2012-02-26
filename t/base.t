use strict;
use warnings;

use Test::More tests => 24;

use_ok 'MovingCamel::Base::Type::Base';
use_ok 'MovingCamel::Base::Type::Int';
use_ok 'MovingCamel::Base::Type::String';
use_ok 'MovingCamel::Base';
use_ok 'MovingCamel::Controller';
use_ok 'MovingCamel::Exception::ReadOnly';
use_ok 'MovingCamel::Exception::RendererNotFound';
use_ok 'MovingCamel::Exception::TemplateError';
use_ok 'MovingCamel::Exception::TypeNotFound';
use_ok 'MovingCamel::Exception::WrongValue';
use_ok 'MovingCamel::Exception';
use_ok 'MovingCamel::Exporter';
use_ok 'MovingCamel::Handler::CGI';
use_ok 'MovingCamel::Handler';
use_ok 'MovingCamel::JSON';
use_ok 'MovingCamel::Renderer::HTML';
use_ok 'MovingCamel::Renderer::JSON';
use_ok 'MovingCamel::Renderer::TEXT';
use_ok 'MovingCamel::Renderer';
use_ok 'MovingCamel::Server::CGI';
use_ok 'MovingCamel::Server::FCGI';
use_ok 'MovingCamel::Server::Simple';
use_ok 'MovingCamel::Template';
use_ok 'MovingCamel';
