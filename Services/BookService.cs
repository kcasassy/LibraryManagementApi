using LibraryManagementApi.DTO;
using LibraryManagementApi.Models;
using LibraryManagementApi.Repositories;

namespace LibraryManagementApi.Services
{
    public class BookService : IBookService
    {
        private readonly IBookRepository _repository;

        public BookService(IBookRepository repository)
        {
            _repository = repository;
        }

        public async Task<List<BookDto>> GetAllAsync()
        {
            var books = await _repository.GetAllAsync();

            return books.Select(book => new BookDto
            {
                Id = book.Id,
                Title = book.Title,
                Author = book.Author,
                ISBN = book.ISBN,
                Category = book.Category,
                TotalCopies = book.TotalCopies,
                AvailableCopies = book.AvailableCopies
            }).ToList();
        }

        public async Task<BookDto?> GetByIdAsync(int id)
        {
            var book = await _repository.GetByIdAsync(id);

            if (book == null)
            {
                return null;
            }

            return new BookDto
            {
                Id = book.Id,
                Title = book.Title,
                Author = book.Author,
                ISBN = book.ISBN,
                Category = book.Category,
                TotalCopies = book.TotalCopies,
                AvailableCopies = book.AvailableCopies
            };
        }

        public async Task<BookDto> CreateAsync(CreateBookDto dto)
        {
            if (dto.TotalCopies < 0)
            {
                throw new InvalidOperationException(
                    "TotalCopies cannot be negative.");
            }

            if (dto.AvailableCopies < 0 ||
                dto.AvailableCopies > dto.TotalCopies)
            {
                throw new InvalidOperationException(
                    "AvailableCopies must be between 0 and TotalCopies.");
            }

            var book = new Book
            {
                Title = dto.Title,
                Author = dto.Author,
                ISBN = dto.ISBN,
                Category = dto.Category,
                TotalCopies = dto.TotalCopies,
                AvailableCopies = dto.AvailableCopies
            };

            var createdBook = await _repository.AddAsync(book);

            return new BookDto
            {
                Id = createdBook.Id,
                Title = createdBook.Title,
                Author = createdBook.Author,
                ISBN = createdBook.ISBN,
                Category = createdBook.Category,
                TotalCopies = createdBook.TotalCopies,
                AvailableCopies = createdBook.AvailableCopies
            };
        }

        public async Task<bool> UpdateAsync(int id, UpdateBookDto dto)
        {
            var book = await _repository.GetByIdAsync(id);

            if (book == null)
            {
                return false;
            }

            if (dto.TotalCopies < 0)
            {
                throw new InvalidOperationException(
                    "TotalCopies cannot be negative.");
            }

            if (dto.AvailableCopies < 0 ||
                dto.AvailableCopies > dto.TotalCopies)
            {
                throw new InvalidOperationException(
                    "AvailableCopies must be between 0 and TotalCopies.");
            }

            book.Title = dto.Title;
            book.Author = dto.Author;
            book.ISBN = dto.ISBN;
            book.Category = dto.Category;
            book.TotalCopies = dto.TotalCopies;
            book.AvailableCopies = dto.AvailableCopies;

            await _repository.UpdateAsync(book);

            return true;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var book = await _repository.GetByIdAsync(id);

            if (book == null)
            {
                return false;
            }

            await _repository.DeleteAsync(book);

            return true;
        }
    }
}